// Copyright (c) 2017, mike. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Support for doing something awesome.
///
/// More dartdocs go here.
library mastodon;

export 'src/mastodon_base.dart';

import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/src/media_type.dart';
// Needed in order to guess extension given mime-type.
import 'package:mime/src/default_extension_map.dart';
import 'dart:math';

import 'package:dartson/dartson.dart';
import 'package:dartson/transformers/date_time.dart';

import 'src/mastodon_base.dart';


/// Simple API to allow access to a Mastodon server.
class Mastodon {
  /// Default Mastodon instance.
  static const String __DEFAULT_BASE_URL = 'mastodon.cloud';
  /// Timeout for all requests to the server in milliseconds.
  static const int __DEFAULT_TIMEOUT = 300;

  Dartson DSON;

  /// OAuth credentials
  String client_id;
  String client_secret;
  String access_token;
  String api_base_url;

  /// Determine what to do in case of server throttling.
  String ratelimit_method;
  num ratelimit_pacefactor;
  int request_timeout;

  /// Set to `true` to get *some* **simple** /debug/ messages.
  bool debug = false;

  // ignore: unused_field
  String _refresh_token;

  // ignore: unused_field
  int _token_expired;

  /// Easiest way to create the server (if you have your token already).
  factory Mastodon.usingAccessToken(String access_token) {
    return new Mastodon(access_token: access_token);
  }

  /// Default constructor that gives full access.
  Mastodon(
      {String this.client_id: '',
        String this.client_secret: '',
        String this.access_token: '',
        String this.api_base_url: __DEFAULT_BASE_URL,
        bool this.debug: false,
        String this.ratelimit_method: 'wait',
        num this.ratelimit_pacefactor: 1.1,
        this.request_timeout: __DEFAULT_TIMEOUT,
        String credentials: ''}) {
    if (!["throw", "wait", "pace"].contains(ratelimit_method)) {
      throw new MastodonIllegalArgumentError('Invalid ratelimit method.');
    }

    DSON = new Dartson.JSON();
    DSON.addTransformer(new DateTimeParser(), DateTime);
  }

  /// Use supplied credentials to generate an OAuth authorisation code.
  dynamic log_in(
      [String username = "",
        String password = "",
        String code = '',
        String redirect_uri = 'urn:ietf:wg:oauth:2.0:oob',
        String refresh_token = '',
        List<String> scopes = const ['read', 'write', 'follow'],
        String to_file = '']) async {
    Map params = {};
    if (client_id.isNotEmpty && client_secret.isNotEmpty) {
      // Use OAuth ID and secret if provided.
      params['client_id'] = this.client_id;
      params['client_secret'] = this.client_secret;
    } else if (code.isNotEmpty) {
      // Check for an OAuth authorisation code.
      params['code'] = code;
      params['grant_type'] = 'authorization_code';
    } else if (refresh_token.isNotEmpty) {
      // An OAuth refresh token can be used to generate
      // a new OAuth authorisation code.
      // Not supported by Mastodon at present?
      params['refresh_token'] = refresh_token;
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

    params['client_id'] = this.client_id;
    params['client_secret'] = this.client_secret;
    params['scope'] = scopes.join(' ');

    var pp = makeParamMap(params);
    Map response;
    try {
      response = await _api_request('POST', '/oauth/token', pp, {}, false);
      access_token = response['access_token'];
      _refresh_token = response.containsKey('refresh_token')
          ? response['refresh_token']
          : '';
      _token_expired =
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

    dynamic sorted(list) {
      var l = list.sublist(0);
      l.sort();
      return l;
    }

    var requested_scopes = sorted(scopes).join(' ');
    var returned_scopes = sorted(response['scope'].split(' ')).join(' ');

    if (returned_scopes != requested_scopes) {
      throw new MastodonAPIError('Granted scopes "$returned_scopes"'
          ' differ from requested scopes "$requested_scopes".');
    }

    return access_token;
  }

  /// Private utility method to manage all server requests.
  dynamic _api_request(
      String method,
      String endpoint, [
        Map<String, String> params = const {},
        Map files = const {},
        bool do_ratelimiting = true,
      ]) async {
    var headers = {};

    //TODO: Add ratelimiting.

    // Generate request headers.
    // All other authorisation methods are handled by params.
    if (access_token.isNotEmpty) {
      headers = {'Authorization': 'Bearer ' + access_token};
    }

    var pp = makeParamMap(params);

    var request_complete = false;
    StreamedResponse response_object;

    while (!request_complete) {
      // This will be reset later if we are running into throttling issues.
      request_complete = true;
      var uri = new Uri.https(api_base_url, endpoint, pp);

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
      response_object = await request.send();

      //TODO: timeout

      if (response_object.statusCode == 401) {
        throw new MastodonAPIError('401 - Unauthorised access.');
      }

      if (response_object.statusCode == 404) {
        throw new MastodonAPIError('Endpoint not found.');
      }

      if (response_object.statusCode == 500) {
        throw new MastodonAPIError('General API problem.');
      }
    }

    String body = await response_object.stream.bytesToString();
    var json;
    json = JSON.decode(body);
    return json;
  }

  /// Ensure all values are strings, then remove any blank parameters.
  /// Handles simple DSON-able objects or Maps.
  Map<String, String> makeParamMap(dynamic obj) {
    var s = DSON.encode(obj);
    var map = JSON.decode(s);
    var m = {};
    map.keys.where((e) => map[e].toString().isNotEmpty).forEach((k) => m[k] = map[k].toString());
    return m;
  }

  //
  // Updates to statuses.
  //

  /// Create a new status.
  dynamic status_post(Post status) async {
    //TODO: check visibility is allowed.

    Post s = status;

    if (!s.sensitivity) s.sensitivity = null;

    Map<String, String> map = makeParamMap(s);

    var response = await _api_request('POST', '/api/v1/statuses', map);
    return response;
  }

  /// Convenience method to create a status from text only.
  dynamic toot(String text) async => status_post(new Post.withText(text));

  /// Delete a Toot.
  dynamic deleteStatus(int id) async =>
      await _api_request('DELETE', '/api/v1/statuses/$id');

  /// Reblog a Toot.
  dynamic reblogStatus(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/statuses/$id/reblog'), new Status());

  /// Un-reblog a Toot.
  dynamic unreblogStatus(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/statuses/$id/unreblog'),
      new Status());

  /// Favourite a Toot.
  dynamic favouriteStatus(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/statuses/$id/favourite'),
      new Status());

  /// Un-favourite a Toot.
  dynamic unfavouriteStatus(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/statuses/$id/unfavourite'),
      new Status());

  //
  // Updates to notifications
  //

  /// Clear notifications.
  dynamic clearNotifications() async =>
      await _api_request('DELETE', '/api/v1/notifications/clear');

  //
  // Updates to account relationships.
  //

  /// Follow an account.
  dynamic followAccount(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/accounts/$id/follow'),
      new Relationship());

  /// Unfollow an account.
  dynamic unfollowAccount(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/accounts/$id/unfollow'),
      new Relationship());

  /// Block an account.
  dynamic blockAccount(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/accounts/$id/block'),
      new Relationship());

  /// Unblock an account.
  dynamic unblockAccount(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/accounts/$id/unblock'),
      new Relationship());

  /// Mute an account.
  dynamic muteAccount(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/accounts/$id/mute'),
      new Relationship());

  /// Unmute an account.
  dynamic unmuteAccount(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/accounts/$id/unmute'),
      new Relationship());

  /// Report an account.
  dynamic reportAccount(int account_id, List<int> status_ids) async => DSON.map(
      await _api_request('POST', '/api/v1/reports',
          makeParamMap({'account_id': account_id, 'status_ids': status_ids})),
      new Report());

  //
  // Updates to follows
  //

  /// Accept a follow request.
  dynamic authoriseFollowRequest(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/follow_requests/$id/authorize'),
      new Account());

  /// Reject a follow request.
  dynamic rejectFollowRequest(int id) async => DSON.map(
      await _api_request('POST', '/api/v1/follow_requests/$id/reject'),
      new Account());

  //
  // Other updates.
  //

  /// Update current account profile.
  /// 'note' is the user's bio. 'avatar' and 'header' are images
  /// encoded in base64, prepended by a content-type
  /// (for example: 'data:image/png;base64,iVBORw0KGgoAAAA[...]')

  dynamic updateAccount(
      {String display_name: '',
        String note: '',
        String avatar: '',
        String header: ''}) async =>
      DSON.map(
          await _api_request(
              'POST',
              '/api/v1/accounts/update_credentials',
              makeParamMap({
                'display_name': display_name,
                'note': note,
                'avatar': avatar,
                'header': header
              })),
          new Relationship());

  /// Post a media item to the server, for later inclusion in a Toot.
  ///
  /// Returns: a reference that can be added to the Toot.
  dynamic postMedia(List media, String mime_type) async {
    if (mime_type.isEmpty)
      throw new MastodonIllegalArgumentError(
          'Could not tell mime type or data passed directly without mime type.');

    var date = new DateTime.now().toIso8601String();

    // Overkill maybe?
    var r = new Random();
    List list = new List.generate(10, (i) => r.nextInt(9).toString());
    var random_suffix = list.join();

    var ext = defaultExtensionMap.keys.firstWhere(
            (k) => defaultExtensionMap[k] == mime_type,
        orElse: () => '');

    var name = 'mastodondartupload${date}_$random_suffix.$ext';
    var mpf = new MultipartFile.fromBytes('file', media,
        filename: name, contentType: new MediaType.parse(mime_type));
    return DSON.map(
        await _api_request('POST', '/api/v1/media', {}, {'file': mpf}),
        new Attachment());
  }

  /// Simpler way of uploading a media item directly from a file.
  dynamic postMediaFile(String media_file) async {
    String mime_type;
    MimeTypeResolver resolver = new MimeTypeResolver();
    mime_type = resolver.lookup(media_file);

    if (mime_type.isEmpty)
      throw new MastodonIllegalArgumentError(
          'Could not tell mime type or data passed directly without mime type.');

    List media = new File(media_file).readAsBytesSync();

    if (media.isEmpty)
      throw new MastodonIllegalArgumentError('Could not read media file.');

    return await postMedia(media, mime_type);
  }

  //
  // Get general information.
  //

  /// Get information about this server.
  dynamic getInstance() async => await _api_request('GET', '/api/v1/instance/');

  /// Fetch statuses, most recent ones first. Timeline can be home, local, public,
  /// or tag/hashtag. See the following functions documentation for what those do.
  /// The default timeline is the "home" timeline.
  /// Returns a list of toot dicts.
  dynamic timeline(TimelineRequest request, [int id]) async {
    Map<String, String> map = makeParamMap(request);

    var tl = request.timeline;
    if (timeline == 'local') {
      tl = 'public';
      map['local'] = 'true';
    } else if (timeline == 'hashtag') {
      tl = 'tag/${request.hashtag}';
    }
    map.remove('hashtag'); // The code above handles hashtags.

    var json;
    if (id == null) {
      json = await _api_request('GET', '/api/v1/timelines/' + tl, map);
    } else {
      json = await _api_request('GET', '/api/v1/accounts/$id/statuses', map);
    }

    List<Status> list = DSON.map(json, new Status(), true) as List<Status>;

    return list;
  }

  //
  // Get information for this account.
  //

  dynamic verifyAccount() async => DSON.map(
      await _api_request('GET', '/api/v1/accounts/verify_credentials'),
      new Account());

  dynamic getAccountRelationships() async => DSON.map(
      await _api_request('GET', '/api/v1/accounts/relationships'),
      new Account(),
      true);

  dynamic getMutes() async =>
      DSON.map(await _api_request('GET', '/api/v1/mutes'), new Account(), true);

  dynamic getBlocks() async => DSON.map(
      await _api_request('GET', '/api/v1/blocks'), new Account(), true);

  dynamic getReports() async => DSON.map(
      await _api_request('GET', '/api/v1/reports'), new Account(), true);

  dynamic getFavourites() async => DSON.map(
      await _api_request('GET', '/api/v1/favourites'), new Status(), true);

  dynamic getFollowRequests() async => DSON.map(
      await _api_request('GET', '/api/v1/follow_requests'),
      new Account(),
      true);

  dynamic getFollows() async => DSON.map(
      await _api_request('GET', '/api/v1/follows'), new Account(), true);

  //
  // Get information about a single Status.
  //

  /// Get a single toot by id.
  dynamic getStatus(int id) async =>
      DSON.map(await _api_request('GET', '/api/v1/statuses/$id'), new Status());

  /// Get a single status card by id.
  dynamic getStatusCard(int id) async => DSON.map(
      await _api_request('GET', '/api/v1/statuses/$id/card'), new Status());

  /// Get ancestors and descendants of a single toot.
  dynamic getStatusContext(int id) async => DSON.map(
      await _api_request('GET', '/api/v1/statuses/$id/context'),
      new Status(),
      true);

  /// Get list of users who have boosted this.
  dynamic getStatusRebloggedBy(int id) async => DSON.map(
      await _api_request('GET', '/api/v1/statuses/$id/reblogged_by'),
      new Account(),
      true);

  /// Get list of users who have favourited this.
  dynamic getStatusFavouritedBy(int id) async => DSON.map(
      await _api_request('GET', '/api/v1/statuses/$id/favourited_by'),
      new Account(),
      true);

  /// Get list of notifications (= mentions, favourites, reblogs, follows).
  dynamic getNotifications([String id = '']) async => DSON.map(
      await _api_request('GET', '/api/v1/notifications/$id'),
      new Notification(),
      true);

  //
  // Get information about other accounts.
  //

  dynamic getAccount(int id) async => DSON.map(
      await _api_request('GET', '/api/v1/accounts/$id'), new Account());

  dynamic getAccountStatuses(int id,
      [TimelineRequest request = null]) async =>
      timeline(request != null ? request : new TimelineRequest(), id);

  dynamic getAccountFollowing(int id) async => DSON.map(
      await _api_request('GET', '/api/v1/accounts/$id/following'),
      new Account(),
      true);

  dynamic getAccountFollowers(int id) async => DSON.map(
      await _api_request('GET', '/api/v1/accounts/$id/followers'),
      new Account(),
      true);

  dynamic findAccounts(String query, {int limit: null}) async => DSON.map(
      await _api_request('GET', '/api/v1/accounts/search',
          makeParamMap({'q': query, 'limit': limit})),
      new Account(),
      true);

  /// Fetch matching hashtags, accounts and statuses.
  /// Will search federated instances if resolve is True.
  dynamic find(String query, {bool resolve: false}) async {
    var map = await _api_request('GET', '/api/v1/search',
        makeParamMap({'q': query, 'resolve': resolve}));
    map['accounts'] = DSON.map(map['accounts'], new Account(), true);
    map['statuses'] = DSON.map(map['statuses'], new Status(), true);
    //map['hashtags'] = DSON.map(map['hashtags'], new Account(), true);
    return map;
  }
}

class MastodonIllegalArgumentError extends ArgumentError {
  final message;
  MastodonIllegalArgumentError(this.message): super(message);
}

class MastodonAPIError extends UnsupportedError {
  MastodonAPIError(String message): super(message);
}
