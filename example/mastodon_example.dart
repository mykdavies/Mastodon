// Copyright (c) 2017, mike. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:mastodon/mastodon.dart';

void main() async {
  final properties = jsonDecode(File('lib/config.json').readAsStringSync());

  // Create your instance. Doesn't actually log on until you call a method.
  final m = Mastodon.usingAccessToken(
    properties['access_token'],
    instance: properties['instance'],
  );

  // Search for a user
  for (var account in await m.findAccounts('myk')) {
    print(account.username);
  }

  // Create a post with an image attached.
  final img = File('test/jackhammer.png').readAsBytesSync();
  final attachment = await m.postMedia(img, 'image/png');

  final post = Post(
      status: "It's Jackhammer Jill!",
      media_ids: [attachment.id],
      visibility: "private");
  final status = await m.postStatus(post);
  await m.deleteStatus(status.id);
}
