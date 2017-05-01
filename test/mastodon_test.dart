// Copyright (c) 2017, mike. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:convert';


import 'package:mastodon/mastodon.dart';
import 'package:test/test.dart';


void main() {
  group('A group of tests', () {
    Mastodon m;
    var properties;

    setUp(() {
      properties = JSON.decode(new File('lib/config.json').readAsStringSync());

      m = new Mastodon.usingAccessToken(properties['access_token']);
    });

    test('First Test', () {
      expect(m.access_token, equals(properties['access_token']), reason: 'access token not stored correctly');
    });

    test('Account Stuff', () async {
      expect(await m.getAccountStatuses('91486'), isNotEmpty, reason: 'No statuses received');
      expect(await m.getAccountFollowing('91486'), isNotEmpty, reason: 'No account followings received');
      expect(await m.findAccounts('myk*'), isNotEmpty, reason: 'No account search results received');

      expect(m.access_token, equals(properties['access_token']), reason: 'access token not stored correctly');
    });


  });
}

