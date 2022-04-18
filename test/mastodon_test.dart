// Copyright (c) 2017, mike. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@Timeout(Duration(seconds: 900))

import 'dart:convert';

import 'dart:io';

import 'package:mastodon/mastodon.dart';
import 'package:test/test.dart';

void main() {
  group('General read-only tests', () {
    late Mastodon m;
    var properties;

    setUpAll(() {
      // See 'lib/example_config.json' for structure.
      properties = jsonDecode(new File('lib/config.json').readAsStringSync());
      m = new Mastodon.usingAccessToken(
        properties['access_token'],
        instance: properties['instance'],
      );
    });

    test('General account-related accesses', () {
      expect(m.accessToken, equals(properties['access_token']),
          reason: 'access token not stored correctly');
    });

    test('Account Stuff', () async {
      expect(await m.getAccountStatuses(91486), isNotEmpty,
          reason: 'No statuses received');
      expect(await m.getAccountFollowing(91486), isNotEmpty,
          reason: 'No account followings received');
      expect(await m.findAccounts('myk'), isNotEmpty,
          reason: 'No account search results received');

      expect(m.accessToken, equals(properties['access_token']),
          reason: 'access token not stored correctly');
    });
  });

  group('Timeline', () {
    var properties;
    late Mastodon m;
    late TimelineRequest tl;

    setUpAll(() {
      // See 'lib/example_config.json' for structure.
      properties = jsonDecode(new File('lib/config.json').readAsStringSync());
      m = Mastodon.usingAccessToken(
        properties['access_token'],
        instance: properties['instance'],
      );
    });

    setUp(() {
      tl = TimelineRequest();
    });

    test('Get timeline by hashtag', () async {
      tl = TimelineRequest(timeline: 'local', hashtag: '#neuhier');
      expect(await m.getTimeline(tl), isNotEmpty,
          reason: 'Could not get my timeline by hashtag.');
    });

    test('Get limited timeline', () async {
      tl = TimelineRequest(timeline: 'local', limit: 3);
      expect(await m.getTimeline(tl), hasLength(3),
          reason: 'Limited timeline search failed.');
    });
  });

  group('Logon', () {
    var properties;

    setUpAll(() {
      // See 'lib/example_config.json' for structure.
      properties = jsonDecode(new File('lib/config.json').readAsStringSync());
    });

    test('Confirm instance okay', () async {
      final m = new Mastodon();

      expect(await m.getInstance(), isNotEmpty,
          reason: 'No access to instance.');
    });

    test('Not logged on', () {
      final m = new Mastodon();

      // Use expectLater to allow the Error to be caught by the matcher.
      expectLater(m.verifyAccount(), throwsUnsupportedError,
          reason: 'Access allowed without authentication.');
    });

    test('Password logon', () async {
      final m = new Mastodon();
      // ignore: unawaited_futures
      expectLater(
          m.logIn(
              properties['username'] ?? 'verybadusername', 'verywrongpassword'),
          throwsArgumentError,
          reason: 'Incorrect password did not raise error.');
      // await m.logIn(properties['username']);
      // expect(m.accessToken, isNotEmpty, reason: 'OAuth access token not saved');

      // throws Unauthorised access
      // expect(await m.verifyAccount(), isNotNull,
      // reason: 'Password logon failed.');
    });

    test('OAuth logon', () async {
      final m = new Mastodon.usingAccessToken(
        properties['access_token'],
        instance: properties['instance'],
      );
      expect(await m.verifyAccount(), isNotNull,
          reason: 'Access token logon failed.');
    });
  });
  group('Posting', () {
    var properties;
    late Mastodon m;
    setUpAll(() {
      // See 'lib/example_config.json' for structure.
      properties = jsonDecode(new File('lib/config.json').readAsStringSync());
      m = new Mastodon.usingAccessToken(
        properties['access_token'],
        instance: properties['instance'],
      );
    });

    test('Post and delete a status', () async {
      final post = Post(status: 'test', visibility: 'private');
      final resp = await m.postStatus(post);
      final id = resp.id;
      final status = await m.getStatus(id);
      expect(id, status.id);
      await m.deleteStatus(id);
    });
    test('Post and delete a status with attachment', () async {
      final img = File('test/jackhammer.png').readAsBytesSync();
      final attachment = await m.postMedia(img, 'image/png');

      final post = Post(
          status: "It's Jackhammer Jill!",
          media_ids: [attachment.id],
          visibility: "private");
      final status = await m.postStatus(post);
      await m.deleteStatus(status.id);
    });
  });
}
