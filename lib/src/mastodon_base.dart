// Copyright (c) 2017, Michael Davies. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

///
/// Key classes that encapsulate information for sharing with
/// the Mastodon server.
///
/// See https://github.com/tootsuite/documentation/blob/master/Using-the-API/API.md for more information.
///

//TODO: fix these!
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, type_annotate_public_apis

import 'package:freezed_annotation/freezed_annotation.dart';

// 2. add 'part' files
part 'mastodon_base.freezed.dart';
part 'mastodon_base.g.dart';

/// User account.
@freezed
class Account with _$Account {
  factory Account({
    required String id,
    required String username,
    required String acct,
    required String display_name,
    required bool locked,
    required DateTime created_at,
    required int followers_count,
    required int following_count,
    required int statuses_count,
    required String note,
    required String url,
    required String avatar,
    required String avatar_static,
    required String header,
    required String header_static,
  }) = _Account;
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  // @override
  // String toString() =>
  //     "$username ${displayName.isNotEmpty ? '($displayName)' : ''}";
}

/// A posted update.
@freezed
class Status with _$Status {
  factory Status({
    required String id,
    required DateTime created_at,
    @Default(null) String? in_reply_to_id,
    @Default(null) String? in_reply_to_account_id,
    required bool sensitive,
    required String spoiler_text,
    @Default(null) String? visibility,
    @Default(null) Map<String, dynamic>? application,
    required Account account,
    required List mentions,
    required List tags,
    required String uri,
    required String content,
    @Default(null) String? url,
    required int reblogs_count,
    required int favourites_count,
    @Default(null) Status? reblog,
    required bool favourited,
    required bool reblogged,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  // @override
  // String toString() => "$id: $account at $created_at-->$content";
}

/// A helper class to create a new status for posting.
@freezed
class Post with _$Post {
  factory Post({
    required String status,
    @Default(null) int? in_reply_to_id,
    @Default(null) List? media_ids,
    @Default(false) bool? sensitivity,
    @Default('public') String? visibility,
    @Default(null) String? spoiler_text,
  }) = _Post;
  factory Post.withText(String text) => Post(
        status: text,
      );

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

/// A notification.
@freezed
class Notification with _$Notification {
  factory Notification({
    required int id,
    required String type,
    required DateTime created_at,
    required Account account,
    required Status status,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  // @override
  // String toString() =>
  //     "$id ($type) ${status != null ? status : ''} ${account != null ? account : ''}";
}

/// A helper class for creating new `getTimeline` requests.
@freezed
class TimelineRequest with _$TimelineRequest {
  factory TimelineRequest({
    String? timeline,
    String? hashtag,
    int? max_id,
    DateTime? since_id,
    int? limit,
  }) = _TimelineRequest;
  factory TimelineRequest.fromJson(Map<String, dynamic> json) =>
      _$TimelineRequestFromJson(json);
}

/// A relationship.
@freezed
class Relationship with _$Relationship {
  factory Relationship({
    required int id,
    required bool following,
    required bool followed_by,
    required bool blocking,
    required bool muting,
    required bool requested,
  }) = _Relationship;
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
}

/// Admin's response to a report of another user.
@freezed
class Report with _$Report {
  factory Report({
    required int id,
    required String action_taken,
  }) = _Report;
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}

/// An attachment.
@freezed
class Attachment with _$Attachment {
  factory Attachment({
    required int id,
    required String type,
    required String url,
    required String remote_url,
    required String preview_url,
    required String text_url,
  }) = _Attachment;
  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}
