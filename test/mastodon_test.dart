// Copyright (c) 2017, mike. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:convert';


import 'package:mastodon/mastodon.dart';
import 'package:test/test.dart';


void main() {
  group('General read-only tests', () {
    Mastodon m;
    var properties;

    setUp(() {
      // See 'lib/example_config.json' for structure.
      properties = JSON.decode(new File('lib/config.json').readAsStringSync());

      m = new Mastodon.usingAccessToken(properties['access_token']);
    });

    test('General account-related accesses', () {
      expect(m.access_token, equals(properties['access_token']),
          reason: 'access token not stored correctly');
    });

    test('Account Stuff', () async {
      expect(await m.getAccountStatuses(91486), isNotEmpty,
          reason: 'No statuses received');
      expect(await m.getAccountFollowing(91486), isNotEmpty,
          reason: 'No account followings received');
      expect(await m.findAccounts('myk*'), isNotEmpty,
          reason: 'No account search results received');

      expect(m.access_token, equals(properties['access_token']),
          reason: 'access token not stored correctly');
    });
  });

  group('Logon', () {
    var properties;

    setUp(() {
      // See 'lib/example_config.json' for structure.
      properties = JSON.decode(new File('lib/config.json').readAsStringSync());
    });

    test('Confirm instance okay', () async {
      Mastodon m = new Mastodon();

      expect(await m.getInstance(), isNotEmpty, reason: 'No access to instance.');
    });


    test('Not logged on', () async {
      Mastodon m = new Mastodon();

      // Use expectLater to allow the Error to be caught by the matcher.
      expectLater(m.verifyAccount(), throwsUnsupportedError,
          reason: 'Password logon failed.');
    });

    test('Password logon', () async {
      Mastodon m = new Mastodon();
      await m.log_in(properties['username'], properties['password']);
      expect(await m.verifyAccount(), isNotNull, reason: 'Password logon failed.');
    });

    test('OAuth logon', () async {
      Mastodon m = new Mastodon.usingAccessToken(properties['access_token']);
      expect(await m.verifyAccount(), isNotNull, reason: 'Access token logon failed.');
    });


  });
}

