// Copyright (c) 2017, Michael Davies. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

///
/// Key classes that encapsulate information for sharing with
/// the Mastodon server.
///
/// See https://docs.joinmastodon.org/api/ for more information.
///

// Needed to stop the linting complaining about the API-driven variable names.
// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
// Recommended for improved readabilty in devtools
// import 'package:flutter/foundation.dart';

// 2. add 'part' files
part 'mastodon_base.freezed.dart';
part 'mastodon_base.g.dart';

/// User account.
@freezed
class Account with _$Account {
  /// Create a new Account. You probably want to use .fromJson() instead.
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

  /// Construct an Account object from a JSON structure.
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  // @override
  // String toString() =>
  //     "$username ${displayName.isNotEmpty ? '($displayName)' : ''}";
}

/// A posted update.
@unfreezed
class Status with _$Status {
  /// Create a new Status. You probably want to use .fromJson() instead.
  factory Status({
    required String id,
    required DateTime created_at,
    @Default(null) String? in_reply_to_id,
    @Default(null) String? in_reply_to_account_id,
    required bool sensitive,
    required String spoiler_text,
    @Default(null) String? visibility,
    //@Default(null) Map<String, dynamic>? application,
    @Default(null) Map<String, dynamic>? application,
    required Account account,
    required List<Mention> mentions,
    required List<Tag> tags,
    required String uri,
    required String content,
    @Default(null) String? url,
    required int reblogs_count,
    required int favourites_count,
    @Default(null) Status? reblog,
    required bool favourited,
    required bool reblogged,
    @Default(null) List<String>? media_ids,
    @Default(null) List<Attachment>? media_attachments,
    @Default(null) String? text,
  }) = _Status;

  /// Construct a Status object from a JSON structure.
  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  // @override
  // String toString() => "$id: $account at $created_at-->$content";
}

/// A helper class to create a new status for posting.
@freezed
class Post with _$Post {
  /// Create a new Post. You may want to use .fromJson() instead.
  factory Post({
    required String status,
    @Default(null) String? in_reply_to_id,
    @Default([]) List<String> media_ids,
    @Default(null) bool? sensitivity,
    @Default(null) String? visibility,
    @Default(null) String? spoiler_text,
  }) = _Post;

  /// Construct a default Post object with just the status message.
  factory Post.withText(String text) => Post(
        status: text,
      );

  /// Construct a Post object from a JSON structure.
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

/// A notification.
@freezed
class Notification with _$Notification {
  /// Create a new Notification. You probably want to use .fromJson() instead.
  factory Notification({
    required String id,
    required String type,
    required DateTime created_at,
    required Account account,
    required Status status,
  }) = _Notification;

  /// Construct a Notification object from a JSON structure.
  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

/// A helper class for creating new `getTimeline` requests.
@freezed
class TimelineRequest with _$TimelineRequest {
  /// Create a new TimelineRequest. You may want to use .fromJson() instead.
  factory TimelineRequest({
    String? timeline,
    String? hashtag,
    int? max_id,
    DateTime? since_id,
    int? limit,
  }) = _TimelineRequest;

  /// Construct a TimelineRequest object from a JSON structure.
  factory TimelineRequest.fromJson(Map<String, dynamic> json) =>
      _$TimelineRequestFromJson(json);
}

/// A relationship.
@freezed
class Relationship with _$Relationship {
  /// Create a new Relationship. You probably want to use .fromJson() instead.
  factory Relationship({
    required String id,
    required bool following,
    required bool followed_by,
    required bool blocking,
    required bool muting,
    required bool requested,
  }) = _Relationship;

  /// Construct a Relationship object from a JSON structure.
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
}

/// Admin's response to a report of another user.
@freezed
class Report with _$Report {
  /// Create a new Report. You probably want to use .fromJson() instead.
  factory Report({
    required String id,
    required String action_taken,
  }) = _Report;

  /// Construct a Report object from a JSON structure.
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}

/// An attachment.
@freezed
class Attachment with _$Attachment {
  /// Create a new Attachment. You probably want to use .fromJson() instead.
  factory Attachment({
    required String id,
    required String type,
    required String url,
    @Default(null) String? remote_url,
    required String preview_url,
    @Default(null) String? text_url,
  }) = _Attachment;

  /// Construct an Attachmet object from a JSON structure.
  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}

/// A tag.
@freezed
class Tag with _$Tag {
  /// Create a new tag. You probably want to use .fromJson() instead.
  factory Tag({
    required String name,
    required String url,
  }) = _Tag;

  /// Construct an Attachmet object from a JSON structure.
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

/// A mention.
@freezed
class Mention with _$Mention {
  /// Create a new tag. You probably want to use .fromJson() instead.
  factory Mention({
    required String id,
    required String username,
    required String acct,
    required String url,
  }) = _Mention;

  /// Construct an Attachmet object from a JSON structure.
  factory Mention.fromJson(Map<String, dynamic> json) =>
      _$MentionFromJson(json);
}
