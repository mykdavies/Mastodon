// Copyright (c) 2017, Michael Davies. All rights reserved. Use of this source
// code is governed by a BSD-style license that can be found in the LICENSE
// file.

///
/// This library provides a single interesting class [Mastodon] which gives
/// easy access to the Mastodon API.
///

library mastodon;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
// Needed in order to guess extension given mime-type.
//import 'package:mime/src/default_extension_map.dart';
//import 'package:webfeed/domain/media/status.dart' as wf;

import 'src/mastodon_base.dart';

export 'src/mastodon_base.dart';

/// Simple API to allow access to a Mastodon server.
class Mastodon {
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
  }

  /// Easiest way to create the server (if you have your token already).
  factory Mastodon.usingAccessToken(String accessToken) =>
      Mastodon(accessToken: accessToken);

  /// Default Mastodon instance.
  static const String _defaultBaseUrl = 'mastodon.cloud';

  /// Timeout for all requests to the server in milliseconds.
  static const int _defaultTimeout = 300;

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
  late String _refreshToken;

  // ignore: unused_field
  late int _tokenExpired;

  /// Use supplied credentials to generate an OAuth authorisation code.
  dynamic logIn(
      [String username = "",
      String password = "",
      String code = '',
      String redirectUri = 'urn:ietf:wg:oauth:2.0:oob',
      String refreshToken = '',
      List<String> scopes = const <String>['read', 'write', 'follow'],
      String toFile = '']) async {
    final params = <String, String>{};
    if (clientId.isNotEmpty && clientSecret.isNotEmpty) {
      // Use OAuth ID and secret if provided.
      params['client_id'] = clientId;
      params['client_secret'] = clientSecret;
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

    params['client_id'] = clientId;
    params['client_secret'] = clientSecret;
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
    var headers = <String, String>{};

    //TODO: Add ratelimiting.

    // Generate request headers.
    // All other authorisation methods are handled by params.
    if (accessToken.isNotEmpty) {
      headers = {'Authorization': 'Bearer $accessToken'};
    }

    final pp = _makeParamMap(params);

    var requestComplete = false;
    late StreamedResponse responseObject;

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
        if (request is MultipartRequest) print(request.files);
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

    final body = await responseObject.stream.bytesToString();
    var json;
    json = jsonDecode(body);
    return json;
  }

  /// Ensure all values are strings, then remove any blank parameters.
  /// Handles simple DSON-able objects or Maps.
  Map<String, String> _makeParamMap(dynamic obj) {
    final s = jsonEncode(obj);
    final map = jsonDecode(s);
    final m = <String, String>{};
    map.keys
        .where((e) => map[e] != null)
        .forEach((k) => m[k] = map[k].toString());
    return m;
  }

  //
  // Updates to statuses.
  //

  /// Create a new status.
  Future<Status> postStatus(Post status) async {
    final s = status;

    final map = _makeParamMap(s);

    final response =
        Status.fromJson(await _apiRequest('POST', '/api/v1/statuses', map));
    return response;
  }

  /// Convenience method to create a status from text only.
  dynamic toot(String text) async => postStatus(new Post.withText(text));

  /// Delete a Toot.
  dynamic deleteStatus(String id) async =>
      await _apiRequest('DELETE', '/api/v1/statuses/$id');

  /// Reblog a Toot.
  dynamic reblogStatus(String id) async =>
      Status.fromJson(await _apiRequest('POST', '/api/v1/statuses/$id/reblog'));

  /// Un-reblog a Toot.
  dynamic unreblogStatus(String id) async => Status.fromJson(
      await _apiRequest('POST', '/api/v1/statuses/$id/unreblog'));

  /// Favourite a Toot.
  dynamic favouriteStatus(String id) async => Status.fromJson(
      await _apiRequest('POST', '/api/v1/statuses/$id/favourite'));

  /// Un-favourite a Toot.
  dynamic unfavouriteStatus(String id) async => Status.fromJson(
      await _apiRequest('POST', '/api/v1/statuses/$id/unfavourite'));

  /// Post a media item to the server, for later inclusion in a Toot.
  ///
  /// Returns: a reference that can be added to the Toot.
  dynamic postMedia(List<int> media, String mimeType) async {
    if (mimeType.isEmpty)
      throw new MastodonIllegalArgumentError('No mime type provided.');

    final date = new DateTime.now().toIso8601String();

    // Overkill maybe?
    final r = new Random();
    final list = new List.generate(10, (i) => r.nextInt(9).toString());
    final randomSuffix = list.join();
    // Will use .data as the extension if it can't find a better one.
    var ext = extensionFromMime(mimeType);
    if (ext == mimeType) ext = 'data';

    final name = 'mastodondartupload${date}_$randomSuffix.$ext';
    final mpf = new MultipartFile.fromBytes('file', media,
        filename: name, contentType: new MediaType.parse(mimeType));
    return Attachment.fromJson(
        await _apiRequest('POST', '/api/v1/media', {}, {'file': mpf}));
  }

  /// Simpler way of uploading a media item directly from a file.
  dynamic postMediaFile(String mediaFile) async {
    String? mimeType;
    final resolver = new MimeTypeResolver();
    mimeType = resolver.lookup(mediaFile);

    if (mimeType == null)
      throw new MastodonIllegalArgumentError(
          'Could not tell mime type of file.');

    final List<int> media = new File(mediaFile).readAsBytesSync();

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
  dynamic followAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/follow'));

  /// Unfollow an account.
  dynamic unfollowAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/unfollow'));

  /// Block an account.
  dynamic blockAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/block'));

  /// Unblock an account.
  dynamic unblockAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/unblock'));

  /// Mute an account.
  dynamic muteAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/mute'));

  /// Unmute an account.
  dynamic unmuteAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/unmute'));

  /// Report an account.
  dynamic reportAccount(int accountId, List<int> statusIds) async =>
      Report.fromJson(await _apiRequest('POST', '/api/v1/reports',
          _makeParamMap({'account_id': accountId, 'status_ids': statusIds})));

  //
  // Updates to follows
  //

  /// Accept a follow request.
  dynamic authoriseFollowRequest(int id) async => Account.fromJson(
      await _apiRequest('POST', '/api/v1/follow_requests/$id/authorize'));

  /// Reject a follow request.
  dynamic rejectFollowRequest(int id) async => Account.fromJson(
      await _apiRequest('POST', '/api/v1/follow_requests/$id/reject'));

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
      Relationship.fromJson(await _apiRequest(
          'POST',
          '/api/v1/accounts/update_credentials',
          _makeParamMap({
            'display_name': displayName,
            'note': note,
            'avatar': avatar,
            'header': header
          })));

  //
  // Get general information.
  //

  /// Get information about this server.
  dynamic getInstance() async => await _apiRequest('GET', '/api/v1/instance/');

  /// Fetch statuses, most recent ones first. Timeline can be home, local, public,
  /// or tag/hashtag. See the following functions documentation for what those do.
  /// The default timeline is the "home" timeline.
  /// Returns a list of toot dicts.
  dynamic getTimeline(TimelineRequest request, [int? id]) async {
    final map = _makeParamMap(request);

    var tl = request.timeline ?? '';
    if (tl == 'local') {
      tl = 'public';
      map['local'] = 'true';
    } else if (tl == 'hashtag') {
      tl = 'tag/${request.hashtag}';
    }
    map.remove('hashtag'); // The code above handles hashtags.

    var json;
    if (id == null) {
      json = await _apiRequest('GET', '/api/v1/timelines/$tl', map);
    } else {
      json = await _apiRequest('GET', '/api/v1/accounts/$id/statuses', map);
    }

    final list = <Status>[for (var s in json) Status.fromJson(s)];

    return list;
  }

  //
  // Get information for this account.
  //

  /// Get details of the logged-in [Account].
  dynamic verifyAccount() async => Account.fromJson(
      await _apiRequest('GET', '/api/v1/accounts/verify_credentials'));

  /// Get list of [Account]s with some [Relationship] with this one.
  dynamic getAccountRelationships() async => Account.fromJson(
      await _apiRequest('GET', '/api/v1/accounts/relationships'));

  /// Get list of [Account]s muted by this one.
  dynamic getMutes() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/mutes'));

  /// Get list of [Account]s blocked by this one.
  dynamic getBlocks() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/blocks'));

  /// Get list of [Account]s reported by this one.
  dynamic getReports() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/reports'));

  /// Get list of [Status]es favourited by this one.
  dynamic getFavourites() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/favourites'));

  /// Get list of [Account]s requesting follows of this one.
  dynamic getFollowRequests() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/follow_requests'));

  /// Get list of [Account]s this one follows.
  dynamic getFollows() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/follows'));

  //
  // Get information about a single Status.
  //

  /// Get a single toot by id.
  Future<Status> getStatus(String id) async =>
      Status.fromJson(await _apiRequest('GET', '/api/v1/statuses/$id'));

  /// Get a single status card by id.
  dynamic getStatusCard(String id) async =>
      Status.fromJson(await _apiRequest('GET', '/api/v1/statuses/$id/card'));

  /// Get ancestors and descendants of a single toot.
  dynamic getStatusContext(String id) async =>
      Status.fromJson(await _apiRequest('GET', '/api/v1/statuses/$id/context'));

  /// Get list of users who have boosted this.
  dynamic getStatusRebloggedBy(String id) async => Account.fromJson(
      await _apiRequest('GET', '/api/v1/statuses/$id/reblogged_by'));

  /// Get list of users who have favourited this.
  dynamic getStatusFavouritedBy(String id) async => Account.fromJson(
      await _apiRequest('GET', '/api/v1/statuses/$id/favourited_by'));

  /// Get list of notifications (= mentions, favourites, reblogs, follows).
  dynamic getNotifications([String id = '']) async => Notification.fromJson(
      await _apiRequest('GET', '/api/v1/notifications/$id'));

  //
  // Get information about other accounts.
  //

  /// Get information about another account. Returns an [Account].
  dynamic getAccount(int id) async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/accounts/$id'));

  /// Get statuses posted by another account. Returns list of [Status].
  dynamic getAccountStatuses(int id, [TimelineRequest? request]) async =>
      getTimeline(request ?? TimelineRequest(), id);

  /// Get accounts followed by this one. Returns list of [Account].
  dynamic getAccountFollowing(int id) async => [
        for (var a
            in await _apiRequest('GET', '/api/v1/accounts/$id/following'))
          Account.fromJson(a)
      ];

  /// Get followers of this account. Returns list of [Account].
  dynamic getAccountFollowers(int id) async => [
        for (var a
            in await _apiRequest('GET', '/api/v1/accounts/$id/followers'))
          Account.fromJson(a)
      ];

  /// Find accounts matching query. Returns list of [Account].
  dynamic findAccounts(String query, {int? limit}) async => [
        for (var a in await _apiRequest('GET', '/api/v1/accounts/search',
            _makeParamMap({'q': query, 'limit': limit})))
          Account.fromJson(a)
      ];

  /// Fetch matching hashtags, accounts and statuses.
  /// Will search federated instances if resolve is True.
  /// Returns a map holding [Account]s, [Status]es, and (String) hashtags.
  dynamic find(String query, {bool resolve: false}) async {
    final map = await _apiRequest('GET', '/api/v1/search',
        _makeParamMap({'q': query, 'resolve': resolve}));
    map['accounts'] = Account.fromJson(map['accounts']);
    map['statuses'] = Account.fromJson(map['statuses']);
    map['hashtags'] = Account.fromJson(map['hashtags']);
    return map;
  }
}

/// Capture some obvious misuses.
class MastodonIllegalArgumentError extends ArgumentError {
  /// Pass straight to super.
  MastodonIllegalArgumentError(message) : super(message);
}

/// Capture some obvious errors.
class MastodonAPIError extends UnsupportedError {
  /// Pass straight to super.
  MastodonAPIError(String message) : super(message);
}
