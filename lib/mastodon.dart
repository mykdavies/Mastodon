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

import 'src/mastodon_base.dart';
export 'src/mastodon_base.dart';

// Most of the public interface is in these parts.
part 'single_status.dart';
part 'other_accounts.dart';
part 'this_account.dart';
part 'other_account_actions.dart';
part 'status_updates.dart';
part 'server_info.dart';

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
  factory Mastodon.usingAccessToken(String accessToken,
          {String instance = _defaultBaseUrl}) =>
      Mastodon(accessToken: accessToken, apiBaseUrl: instance);

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
  /// Use at your own risk :-(
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

    // Helper function
    dynamic _sorted(list) => list.sublist(0)..sort();

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
    Map<String, dynamic> params = const {},
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

    //final pp = _makeParamMap(params);

    var requestComplete = false;
    late StreamedResponse responseObject;

    while (!requestComplete) {
      // This will be reset later if we are running into throttling issues.
      requestComplete = true;
      final uri = new Uri.https(apiBaseUrl, endpoint, params);

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
      if (debug) {
        print(responseObject);
      }

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
    // Quick and dirty way of getting properties into map format.
    final map = jsonDecode(jsonEncode(obj));
    final m = <String, String>{};
    for (String k in map.keys.where((e) => map[e] != null)) {
      // Mastodon API has '[]' on the end of list-type parameters,
      // and takes the list itself without [].
      if (map[k] is List && !k.endsWith('[]')) {
        final klist = '$k[]';
        final wrapped = map[k].map((e) => e.toString()).join(',');
        m[klist] = wrapped;
      } else {
        m[k] = map[k].toString();
      }
    }
    return m;
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
