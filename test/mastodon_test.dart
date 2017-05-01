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

    setUpAll(() {
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

  group('Timeline', () {
    var properties;
    Mastodon m;
    TimelineRequest tl;

    setUpAll(() {
      // See 'lib/example_config.json' for structure.
      properties = JSON.decode(new File('lib/config.json').readAsStringSync());
      m = new Mastodon.usingAccessToken(properties['access_token']);
    });

    setUp(() {
      tl = new TimelineRequest();
    });

    test('Get timeline by hashtag', () async {
      tl.hashtag = 'boingboing';
      expect(await m.getTimeline(tl), isNotEmpty,
          reason: 'Could not get my timeline by hashtag.');
    });

    test('Get limited timeline', () async {
      tl.limit = 3;
      expect(await m.getTimeline(tl), hasLength(3),
          reason: 'Limited timeline search failed.');
    });
  });

  group('Logon', () {
    var properties;

    setUpAll(() {
      // See 'lib/example_config.json' for structure.
      properties = JSON.decode(new File('lib/config.json').readAsStringSync());
    });

    test('Confirm instance okay', () async {
      Mastodon m = new Mastodon();

      expect(await m.getInstance(), isNotEmpty,
          reason: 'No access to instance.');
    });

    test('Not logged on', () async {
      Mastodon m = new Mastodon();

      // Use expectLater to allow the Error to be caught by the matcher.
      expectLater(m.verifyAccount(), throwsUnsupportedError,
          reason: 'Password logon failed.');
    });

    test('Password logon', () async {
      Mastodon m = new Mastodon();
      expectLater(m.log_in(properties['username'], 'verywrongpassword'),
          throwsArgumentError,
          reason: 'Incorrect password did not raise error.');
      await m.log_in(properties['username'], properties['password']);
      expect(m.access_token, isNotEmpty,
          reason: 'OAuth access token not saved');
      expect(await m.verifyAccount(), isNotNull,
          reason: 'Password logon failed.');
    });

    test('OAuth logon', () async {
      Mastodon m = new Mastodon.usingAccessToken(properties['access_token']);
      expect(await m.verifyAccount(), isNotNull,
          reason: 'Access token logon failed.');
    });
  });
}
