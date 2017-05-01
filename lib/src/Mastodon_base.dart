// Copyright (c) 2017, mike. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.


import 'package:dartson/dartson.dart';

@Entity()
class Account {
  int id;
  String username;
  String acct;
  String display_name;
  bool locked;
  DateTime created_at;
  int followers_count;
  int following_count;
  int statuses_count;
  String note;
  String url;
  String avatar;
  String avatar_static;
  String header;
  String header_static;

  String toString() => "$username ${display_name.isNotEmpty ? '(' + display_name + ')' : ''}";
}

@Entity()
class Status {
  int id;
  DateTime created_at;
  int in_reply_to_id;
  int in_reply_to_account_id;
  bool sensitive;
  String spoiler_text;
  String visibility;
  Map application;
  Account account;
  List mentions;
  List tags;
  String uri;
  String content;
  String url;
  int reblogs_count;
  int favourites_count;
  var reblog;
  var favourited;
  var reblogged;

  String toString() => "$id: $account at $created_at-->$content";
}

@Entity()
class Post {
  Post();
  factory Post.withText(String text) {
    var p = new Post();
    p.status = text;
    return p;
  }
  String status;
  int in_reply_to_id;
  List media_ids;
  bool sensitivity = false;
  String visibility;
  String spoiler_text;
}

@Entity()
class Notification {
  int id;
  String type;
  DateTime created_at;
  Account account;
  Status status;

  String toString() => "$id ($type) ${status != null ? status : ''} ${account != null ? account : ''}";

}

@Entity()
class TimelineRequest {
  String timeline = 'home';
  String hashtag = '';
  int max_id;
  DateTime since_id;
  int limit;
}

@Entity()
class Relationship {
  int id;
  bool following = false;
  bool followed_by = false;
  bool blocking = false;
  bool muting = false;
  bool requested = false;
}

@Entity()
class Report {
  int id;
  String action_taken='';
}

@Entity()
class Attachment {
  int id;
  String type;
  String url;
  String remote_url;
  String preview_url;
  String text_url;
}
