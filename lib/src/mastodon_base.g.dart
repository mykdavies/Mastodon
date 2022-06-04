// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Account _$$_AccountFromJson(Map<String, dynamic> json) => _$_Account(
      id: json['id'] as String,
      username: json['username'] as String,
      acct: json['acct'] as String,
      display_name: json['display_name'] as String,
      locked: json['locked'] as bool,
      created_at: DateTime.parse(json['created_at'] as String),
      followers_count: json['followers_count'] as int,
      following_count: json['following_count'] as int,
      statuses_count: json['statuses_count'] as int,
      note: json['note'] as String,
      url: json['url'] as String,
      avatar: json['avatar'] as String,
      avatar_static: json['avatar_static'] as String,
      header: json['header'] as String,
      header_static: json['header_static'] as String,
    );

Map<String, dynamic> _$$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'acct': instance.acct,
      'display_name': instance.display_name,
      'locked': instance.locked,
      'created_at': instance.created_at.toIso8601String(),
      'followers_count': instance.followers_count,
      'following_count': instance.following_count,
      'statuses_count': instance.statuses_count,
      'note': instance.note,
      'url': instance.url,
      'avatar': instance.avatar,
      'avatar_static': instance.avatar_static,
      'header': instance.header,
      'header_static': instance.header_static,
    };

_$_Status _$$_StatusFromJson(Map<String, dynamic> json) => _$_Status(
      id: json['id'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      in_reply_to_id: json['in_reply_to_id'] as String? ?? null,
      in_reply_to_account_id: json['in_reply_to_account_id'] as String? ?? null,
      sensitive: json['sensitive'] as bool,
      spoiler_text: json['spoiler_text'] as String,
      visibility: json['visibility'] as String? ?? null,
      application: json['application'] as Map<String, dynamic>? ?? null,
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      mentions: (json['mentions'] as List<dynamic>)
          .map((e) => Mention.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      uri: json['uri'] as String,
      content: json['content'] as String,
      url: json['url'] as String? ?? null,
      reblogs_count: json['reblogs_count'] as int,
      favourites_count: json['favourites_count'] as int,
      reblog: json['reblog'] == null
          ? null
          : Status.fromJson(json['reblog'] as Map<String, dynamic>),
      favourited: json['favourited'] as bool,
      reblogged: json['reblogged'] as bool,
      media_ids: (json['media_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          null,
      media_attachments: (json['media_attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          null,
      text: json['text'] as String? ?? null,
    );

Map<String, dynamic> _$$_StatusToJson(_$_Status instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at.toIso8601String(),
      'in_reply_to_id': instance.in_reply_to_id,
      'in_reply_to_account_id': instance.in_reply_to_account_id,
      'sensitive': instance.sensitive,
      'spoiler_text': instance.spoiler_text,
      'visibility': instance.visibility,
      'application': instance.application,
      'account': instance.account,
      'mentions': instance.mentions,
      'tags': instance.tags,
      'uri': instance.uri,
      'content': instance.content,
      'url': instance.url,
      'reblogs_count': instance.reblogs_count,
      'favourites_count': instance.favourites_count,
      'reblog': instance.reblog,
      'favourited': instance.favourited,
      'reblogged': instance.reblogged,
      'media_ids': instance.media_ids,
      'media_attachments': instance.media_attachments,
      'text': instance.text,
    };

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      status: json['status'] as String,
      in_reply_to_id: json['in_reply_to_id'] as String? ?? null,
      media_ids: (json['media_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sensitivity: json['sensitivity'] as bool? ?? null,
      visibility: json['visibility'] as String? ?? null,
      spoiler_text: json['spoiler_text'] as String? ?? null,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'status': instance.status,
      'in_reply_to_id': instance.in_reply_to_id,
      'media_ids': instance.media_ids,
      'sensitivity': instance.sensitivity,
      'visibility': instance.visibility,
      'spoiler_text': instance.spoiler_text,
    };

_$_Notification _$$_NotificationFromJson(Map<String, dynamic> json) =>
    _$_Notification(
      id: json['id'] as String,
      type: json['type'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NotificationToJson(_$_Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'created_at': instance.created_at.toIso8601String(),
      'account': instance.account,
      'status': instance.status,
    };

_$_TimelineRequest _$$_TimelineRequestFromJson(Map<String, dynamic> json) =>
    _$_TimelineRequest(
      timeline: json['timeline'] as String?,
      hashtag: json['hashtag'] as String?,
      max_id: json['max_id'] as int?,
      since_id: json['since_id'] == null
          ? null
          : DateTime.parse(json['since_id'] as String),
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$$_TimelineRequestToJson(_$_TimelineRequest instance) =>
    <String, dynamic>{
      'timeline': instance.timeline,
      'hashtag': instance.hashtag,
      'max_id': instance.max_id,
      'since_id': instance.since_id?.toIso8601String(),
      'limit': instance.limit,
    };

_$_Relationship _$$_RelationshipFromJson(Map<String, dynamic> json) =>
    _$_Relationship(
      id: json['id'] as String,
      following: json['following'] as bool,
      followed_by: json['followed_by'] as bool,
      blocking: json['blocking'] as bool,
      muting: json['muting'] as bool,
      requested: json['requested'] as bool,
    );

Map<String, dynamic> _$$_RelationshipToJson(_$_Relationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'following': instance.following,
      'followed_by': instance.followed_by,
      'blocking': instance.blocking,
      'muting': instance.muting,
      'requested': instance.requested,
    };

_$_Report _$$_ReportFromJson(Map<String, dynamic> json) => _$_Report(
      id: json['id'] as String,
      action_taken: json['action_taken'] as String,
    );

Map<String, dynamic> _$$_ReportToJson(_$_Report instance) => <String, dynamic>{
      'id': instance.id,
      'action_taken': instance.action_taken,
    };

_$_Attachment _$$_AttachmentFromJson(Map<String, dynamic> json) =>
    _$_Attachment(
      id: json['id'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      remote_url: json['remote_url'] as String? ?? null,
      preview_url: json['preview_url'] as String,
      text_url: json['text_url'] as String? ?? null,
    );

Map<String, dynamic> _$$_AttachmentToJson(_$_Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'remote_url': instance.remote_url,
      'preview_url': instance.preview_url,
      'text_url': instance.text_url,
    };

_$_Tag _$$_TagFromJson(Map<String, dynamic> json) => _$_Tag(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_TagToJson(_$_Tag instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

_$_Mention _$$_MentionFromJson(Map<String, dynamic> json) => _$_Mention(
      id: json['id'] as String,
      username: json['username'] as String,
      acct: json['acct'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_MentionToJson(_$_Mention instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'acct': instance.acct,
      'url': instance.url,
    };
