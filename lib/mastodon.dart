// Copyright (c) 2017, Michael Davies. All rights reserved. Use of this source
// code is governed by a BSD-style license that can be found in the LICENSE
// file.

///
/// This library provides a single interesting class [Mastodon] which gives
/// easy access to the Mastodon API.
///

library mastodon;

export 'src/mastodon_base.dart';

import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
// Needed in order to guess extension given mime-type.
import 'package:mime/src/default_extension_map.dart';
import 'dart:math';

import 'package:dartson/dartson.dart';
import 'package:dartson/transformers/date_time.dart';

import 'src/mastodon_base.dart';


/// Simple API to allow access to a Mastodon server.
class Mastodon {
  /// Default Mastodon instance.
  static const String _defaultBaseUrl = 'mastodon.cloud';
  /// Timeout for all requests to the server in milliseconds.
  static const int _defaultTimeout = 300;

  static Dartson _dson;

  // OAuth credentials
  /// OAuth id.
  String clientId;
  /// OAuth client secret.
  String clientSecret;
  /// OAuth generated access token.
  String accessToken;
  /// Base URL for the wanted Mastodon server.
  String apiBaseUrl;

  // TODO: implement rate limiting.
  /// Determine what to do in case of server throttling.
  String ratelimitMethod;
  /// Timing for rate-limiting.
  num ratelimitPaceFactor;
  /// Request timeout.
  int requestTimeout;

  /// Set to `true` to get *some* **simple** /debug/ messages.
  bool debug = false;

  // ignore: unused_field
  String _refreshToken;

  // ignore: unused_field
  int _tokenExpired;

  /// Default constructor that gives full access.
  Mastodon(
      {this.clientId: '',
        this.clientSecret: '',
        this.accessToken: '',
        this.apiBaseUrl: _defaultBaseUrl,
        this.debug: false,
        this.ratelimitMethod: 'wait',
        this.ratelimitPaceFactor: 1.1,
        this.requestTimeout: _defaultTimeout,
        String credentials: ''}) {
    if (!["throw", "wait", "pace"].contains(ratelimitMethod)) {
      throw new MastodonIllegalArgumentError('Invalid ratelimit method.');
    }

    _dson = new Dartson.JSON();
    _dson.addTransformer(new DateTimeParser(), DateTime);
  }

  /// Easiest way to create the server (if you have your token already).
  factory Mastodon.usingAccessToken(String accessToken) {
    return new Mastodon(accessToken: accessToken);
  }


  /// Use supplied credentials to generate an OAuth authorisation code.
  dynamic logIn(
      [String username = "",
        String password = "",
        String code = '',
        String redirectUri = 'urn:ietf:wg:oauth:2.0:oob',
        String refreshToken = '',
        List<String> scopes = const<String> ['read', 'write', 'follow'],
        String toFile = '']) async {
    final Map params = {};
    if (clientId.isNotEmpty && clientSecret.isNotEmpty) {
      // Use OAuth ID and secret if provided.
      params['client_id'] = this.clientId;
      params['client_secret'] = this.clientSecret;
    } else if (code.isNotEmpty) {
      // Check for an OAuth authorisation code.
      params['code'] = code;
      params['grant_type'] = 'authorization_code';
    } else if (refreshToken.isNotEmpty) {
      // An OAuth refresh token can be used to generate
      // a new OAuth authorisation code.
      // Not supported by Mastodon at present?
      params['refresh_token'] = refreshToken;
      params['grant_type'] = 'refresh_token';
    } else if (username.isNotEmpty && password.isNotEmpty) {
      // Use the account username and password to generate an OAuth
      // authorisation code.
      params['username'] = username;
      params['password'] = password;

      params['grant_type'] = 'password';
    } else {
      throw new MastodonIllegalArgumentError(
          'Invalid arguments given. OAuth ID+Secret, OAuth auth/refresh code,'
              ' or username+password are required.');
    }

    params['client_id'] = this.clientId;
    params['client_secret'] = this.clientSecret;
    params['scope'] = scopes.join(' ');

    final pp = _makeParamMap(params);
    Map response;
    try {
      response = await _apiRequest('POST', '/oauth/token', pp, {}, false);
      accessToken = response['access_token'];
      _refreshToken = response.containsKey('refresh_token')
          ? response['refresh_token']
          : '';
      _tokenExpired =
      response.containsKey('expires_in') ? response['expires_in'] : 0;
    } catch (e) {
      if (username.isNotEmpty || password.isNotEmpty) {
        throw new MastodonIllegalArgumentError(
            'Invalid user name, password, or redirect_uris: $e');
      } else if (code.isNotEmpty) {
        throw new MastodonIllegalArgumentError(
            'Invalid access token or redirect_uris: $e');
      } else {
        throw new MastodonIllegalArgumentError('Invalid request: $e');
      }
    }

    dynamic _sorted(list) {
      final l = list.sublist(0);
      // ignore: cascade_invocations
      l.sort();
      return l;
    }

    final requestedScopes = _sorted(scopes).join(' ');
    final returnedScopes = _sorted(response['scope'].split(' ')).join(' ');

    if (returnedScopes != requestedScopes) {
      throw new MastodonAPIError('Granted scopes "$returnedScopes"'
          ' differ from requested scopes "$requestedScopes".');
    }

    return accessToken;
  }

  /// Private utility method to manage all server requests.
  dynamic _apiRequest(
      String method,
      String endpoint, [
        Map<String, String> params = const {},
        Map files = const {},
        bool doRateLimiting = true,
      ]) async {
    var headers = {};

    //TODO: Add ratelimiting.

    // Generate request headers.
    // All other authorisation methods are handled by params.
    if (accessToken.isNotEmpty) {
      headers = {'Authorization': 'Bearer ' + accessToken};
    }

    final pp = _makeParamMap(params);

    var requestComplete = false;
    StreamedResponse responseObject;

    while (!requestComplete) {
      // This will be reset later if we are running into throttling issues.
      requestComplete = true;
      final uri = new Uri.https(apiBaseUrl, endpoint, pp);

      var request;

      if (files.isEmpty) {
        request = new Request(method, uri);
      } else {
        request = new MultipartRequest(method, uri);
        for (var f in files.keys) {
          await request.files.add(files[f]);
        }
      }

      await request.headers.addAll(headers);
      if (debug) {
        print(request);
        print(request.headers);
        print(request.files);
      }
      responseObject = await request.send();

      //TODO:  detect and handle timeout.

      if (responseObject.statusCode == 401) {
        throw new MastodonAPIError('401 - Unauthorised access.');
      }

      if (responseObject.statusCode == 404) {
        throw new MastodonAPIError('Endpoint not found.');
      }

      if (responseObject.statusCode == 500) {
        throw new MastodonAPIError('General API problem.');
      }
    }

    final String body = await responseObject.stream.bytesToString();
    var json;
    json = JSON.decode(body);
    return json;
  }

  /// Ensure all values are strings, then remove any blank parameters.
  /// Handles simple DSON-able objects or Maps.
  Map<String, String> _makeParamMap(dynamic obj) {
    final s = _dson.encode(obj);
    final map = JSON.decode(s);
    final m = {};
    map.keys.where((e) => map[e].toString().isNotEmpty).forEach((k) => m[k] = map[k].toString());
    return m;
  }

  //
  // Updates to statuses.
  //

  /// Create a new status.
  dynamic postStatus(Post status) async {
    //TODO: check visibility is allowed.

    final Post s = status;

    if (!s.sensitivity) s.sensitivity = null;

    final Map<String, String> map = _makeParamMap(s);

    final response = await _apiRequest('POST', '/api/v1/statuses', map);
    return response;
  }

  /// Convenience method to create a status from text only.
  dynamic toot(String text) async => postStatus(new Post.withText(text));

  /// Delete a Toot.
  dynamic deleteStatus(int id) async =>
      await _apiRequest('DELETE', '/api/v1/statuses/$id');

  /// Reblog a Toot.
  dynamic reblogStatus(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/statuses/$id/reblog'), new Status());

  /// Un-reblog a Toot.
  dynamic unreblogStatus(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/statuses/$id/unreblog'),
      new Status());

  /// Favourite a Toot.
  dynamic favouriteStatus(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/statuses/$id/favourite'),
      new Status());

  /// Un-favourite a Toot.
  dynamic unfavouriteStatus(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/statuses/$id/unfavourite'),
      new Status());

  /// Post a media item to the server, for later inclusion in a Toot.
  ///
  /// Returns: a reference that can be added to the Toot.
  dynamic postMedia(List media, String mimeType) async {
    if (mimeType.isEmpty)
      throw new MastodonIllegalArgumentError('No mime type provided.');

    final date = new DateTime.now().toIso8601String();

    // Overkill maybe?
    final r = new Random();
    final list = new List.generate(10, (i) => r.nextInt(9).toString());
    final randomSuffix = list.join();

    final ext = defaultExtensionMap.keys.firstWhere(
            (k) => defaultExtensionMap[k] == mimeType,
        orElse: () => '');

    final name = 'mastodondartupload${date}_$randomSuffix.$ext';
    final mpf = new MultipartFile.fromBytes('file', media,
        filename: name, contentType: new MediaType.parse(mimeType));
    return _dson.map(
        await _apiRequest('POST', '/api/v1/media', {}, {'file': mpf}),
        new Attachment());
  }

  /// Simpler way of uploading a media item directly from a file.
  dynamic postMediaFile(String mediaFile) async {
    String mimeType;
    final MimeTypeResolver resolver = new MimeTypeResolver();
    mimeType = resolver.lookup(mediaFile);

    if (mimeType.isEmpty)
      throw new MastodonIllegalArgumentError('Could not tell mime type of file.');

    final List media = new File(mediaFile).readAsBytesSync();

    if (media.isEmpty)
      throw new MastodonIllegalArgumentError('Could not read media file.');

    return await postMedia(media, mimeType);
  }



  //
  // Updates to notifications
  //

  /// Clear notifications.
  dynamic clearNotifications() async =>
      await _apiRequest('DELETE', '/api/v1/notifications/clear');

  //
  // Updates to account relationships.
  //

  /// Follow an account.
  dynamic followAccount(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/accounts/$id/follow'),
      new Relationship());

  /// Unfollow an account.
  dynamic unfollowAccount(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/accounts/$id/unfollow'),
      new Relationship());

  /// Block an account.
  dynamic blockAccount(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/accounts/$id/block'),
      new Relationship());

  /// Unblock an account.
  dynamic unblockAccount(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/accounts/$id/unblock'),
      new Relationship());

  /// Mute an account.
  dynamic muteAccount(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/accounts/$id/mute'),
      new Relationship());

  /// Unmute an account.
  dynamic unmuteAccount(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/accounts/$id/unmute'),
      new Relationship());

  /// Report an account.
  dynamic reportAccount(int accountId, List<int> statusIds) async => _dson.map(
      await _apiRequest('POST', '/api/v1/reports',
          _makeParamMap({'account_id': accountId, 'status_ids': statusIds})),
      new Report());

  //
  // Updates to follows
  //

  /// Accept a follow request.
  dynamic authoriseFollowRequest(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/follow_requests/$id/authorize'),
      new Account());

  /// Reject a follow request.
  dynamic rejectFollowRequest(int id) async => _dson.map(
      await _apiRequest('POST', '/api/v1/follow_requests/$id/reject'),
      new Account());

  //
  // Other updates.
  //

  /// Update current account profile.
  /// 'note' is the user's bio. 'avatar' and 'header' are images
  /// encoded in base64, prepended by a content-type
  /// (for example: 'data:image/png;base64,iVBORw0KGgoAAAA[...]')

  dynamic updateAccount(
      {String displayName: '',
        String note: '',
        String avatar: '',
        String header: ''}) async =>
      _dson.map(
          await _apiRequest(
              'POST',
              '/api/v1/accounts/update_credentials',
              _makeParamMap({
                'display_name': displayName,
                'note': note,
                'avatar': avatar,
                'header': header
              })),
          new Relationship());

  //
  // Get general information.
  //

  /// Get information about this server.
  dynamic getInstance() async => await _apiRequest('GET', '/api/v1/instance/');

  /// Fetch statuses, most recent ones first. Timeline can be home, local, public,
  /// or tag/hashtag. See the following functions documentation for what those do.
  /// The default timeline is the "home" timeline.
  /// Returns a list of toot dicts.
  dynamic getTimeline(TimelineRequest request, [int id]) async {
    final Map<String, String> map = _makeParamMap(request);

    var tl = request.timeline;
    if (getTimeline == 'local') {
      tl = 'public';
      map['local'] = 'true';
    } else if (getTimeline == 'hashtag') {
      tl = 'tag/${request.hashtag}';
    }
    map.remove('hashtag'); // The code above handles hashtags.

    var json;
    if (id == null) {
      json = await _apiRequest('GET', '/api/v1/timelines/' + tl, map);
    } else {
      json = await _apiRequest('GET', '/api/v1/accounts/$id/statuses', map);
    }

    final List<Status> list = _dson.map(json, new Status(), true);

    return list;
  }

  //
  // Get information for this account.
  //

  /// Get details of the logged-in [Account].
  dynamic verifyAccount() async => _dson.map(
      await _apiRequest('GET', '/api/v1/accounts/verify_credentials'),
      new Account());

  /// Get list of [Account]s with some [Relationship] with this one.
  dynamic getAccountRelationships() async => _dson.map(
      await _apiRequest('GET', '/api/v1/accounts/relationships'),
      new Account(),
      true);

  /// Get list of [Account]s muted by this one.
  dynamic getMutes() async =>
      _dson.map(await _apiRequest('GET', '/api/v1/mutes'), new Account(), true);

  /// Get list of [Account]s blocked by this one.
  dynamic getBlocks() async => _dson.map(
      await _apiRequest('GET', '/api/v1/blocks'), new Account(), true);

  /// Get list of [Account]s reported by this one.
  dynamic getReports() async => _dson.map(
      await _apiRequest('GET', '/api/v1/reports'), new Account(), true);

  /// Get list of [Status]es favourited by this one.
  dynamic getFavourites() async => _dson.map(
      await _apiRequest('GET', '/api/v1/favourites'), new Status(), true);

  /// Get list of [Account]s requesting follows of this one.
  dynamic getFollowRequests() async => _dson.map(
      await _apiRequest('GET', '/api/v1/follow_requests'),
      new Account(),
      true);

  /// Get list of [Account]s this one follows.
  dynamic getFollows() async => _dson.map(
      await _apiRequest('GET', '/api/v1/follows'), new Account(), true);

  //
  // Get information about a single Status.
  //

  /// Get a single toot by id.
  dynamic getStatus(int id) async =>
      _dson.map(await _apiRequest('GET', '/api/v1/statuses/$id'), new Status());

  /// Get a single status card by id.
  dynamic getStatusCard(int id) async => _dson.map(
      await _apiRequest('GET', '/api/v1/statuses/$id/card'), new Status());

  /// Get ancestors and descendants of a single toot.
  dynamic getStatusContext(int id) async => _dson.map(
      await _apiRequest('GET', '/api/v1/statuses/$id/context'),
      new Status(),
      true);

  /// Get list of users who have boosted this.
  dynamic getStatusRebloggedBy(int id) async => _dson.map(
      await _apiRequest('GET', '/api/v1/statuses/$id/reblogged_by'),
      new Account(),
      true);

  /// Get list of users who have favourited this.
  dynamic getStatusFavouritedBy(int id) async => _dson.map(
      await _apiRequest('GET', '/api/v1/statuses/$id/favourited_by'),
      new Account(),
      true);

  /// Get list of notifications (= mentions, favourites, reblogs, follows).
  dynamic getNotifications([String id = '']) async => _dson.map(
      await _apiRequest('GET', '/api/v1/notifications/$id'),
      new Notification(),
      true);

  //
  // Get information about other accounts.
  //

  /// Get information about another account. Returns an [Account].
  dynamic getAccount(int id) async => _dson.map(
      await _apiRequest('GET', '/api/v1/accounts/$id'), new Account());

  /// Get statuses posted by another account. Returns list of [Status].
  dynamic getAccountStatuses(int id,
      [TimelineRequest request = null]) async =>
      getTimeline(request != null ? request : new TimelineRequest(), id);

  /// Get accounts followed by this one. Returns list of [Account].
  dynamic getAccountFollowing(int id) async => _dson.map(
      await _apiRequest('GET', '/api/v1/accounts/$id/following'),
      new Account(),
      true);

  /// Get followers of this account. Returns list of [Account].
  dynamic getAccountFollowers(int id) async => _dson.map(
      await _apiRequest('GET', '/api/v1/accounts/$id/followers'),
      new Account(),
      true);

  /// Find accounts matching query. Returns list of [Account].
  dynamic findAccounts(String query, {int limit: null}) async => _dson.map(
      await _apiRequest('GET', '/api/v1/accounts/search',
          _makeParamMap({'q': query, 'limit': limit})),
      new Account(),
      true);

  /// Fetch matching hashtags, accounts and statuses.
  /// Will search federated instances if resolve is True.
  /// Returns a map holding [Account]s, [Status]es, and (String) hashtags.
  dynamic find(String query, {bool resolve: false}) async {
    final map = await _apiRequest('GET', '/api/v1/search',
        _makeParamMap({'q': query, 'resolve': resolve}));
    map['accounts'] = _dson.map(map['accounts'], new Account(), true);
    map['statuses'] = _dson.map(map['statuses'], new Status(), true);
    //map['hashtags'] = DSON.map(map['hashtags'], new Account(), true);
    return map;
  }
}

/// Capture some obvious misuses.
class MastodonIllegalArgumentError extends ArgumentError {
  /// Pass straight to super.
  MastodonIllegalArgumentError(message): super(message);
}

/// Capture some obvious errors.
class MastodonAPIError extends UnsupportedError {
  /// Pass straight to super.
  MastodonAPIError(String message): super(message);
}
