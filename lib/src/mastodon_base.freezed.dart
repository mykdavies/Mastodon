// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mastodon_base.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
class _$AccountTearOff {
  const _$AccountTearOff();

  _Account call(
      {required String id,
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
      required String header_static}) {
    return _Account(
      id: id,
      username: username,
      acct: acct,
      display_name: display_name,
      locked: locked,
      created_at: created_at,
      followers_count: followers_count,
      following_count: following_count,
      statuses_count: statuses_count,
      note: note,
      url: url,
      avatar: avatar,
      avatar_static: avatar_static,
      header: header,
      header_static: header_static,
    );
  }

  Account fromJson(Map<String, Object?> json) {
    return Account.fromJson(json);
  }
}

/// @nodoc
const $Account = _$AccountTearOff();

/// @nodoc
mixin _$Account {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get acct => throw _privateConstructorUsedError;
  String get display_name => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  int get followers_count => throw _privateConstructorUsedError;
  int get following_count => throw _privateConstructorUsedError;
  int get statuses_count => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get avatar_static => throw _privateConstructorUsedError;
  String get header => throw _privateConstructorUsedError;
  String get header_static => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String username,
      String acct,
      String display_name,
      bool locked,
      DateTime created_at,
      int followers_count,
      int following_count,
      int statuses_count,
      String note,
      String url,
      String avatar,
      String avatar_static,
      String header,
      String header_static});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res> implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  final Account _value;
  // ignore: unused_field
  final $Res Function(Account) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? acct = freezed,
    Object? display_name = freezed,
    Object? locked = freezed,
    Object? created_at = freezed,
    Object? followers_count = freezed,
    Object? following_count = freezed,
    Object? statuses_count = freezed,
    Object? note = freezed,
    Object? url = freezed,
    Object? avatar = freezed,
    Object? avatar_static = freezed,
    Object? header = freezed,
    Object? header_static = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      acct: acct == freezed
          ? _value.acct
          : acct // ignore: cast_nullable_to_non_nullable
              as String,
      display_name: display_name == freezed
          ? _value.display_name
          : display_name // ignore: cast_nullable_to_non_nullable
              as String,
      locked: locked == freezed
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      followers_count: followers_count == freezed
          ? _value.followers_count
          : followers_count // ignore: cast_nullable_to_non_nullable
              as int,
      following_count: following_count == freezed
          ? _value.following_count
          : following_count // ignore: cast_nullable_to_non_nullable
              as int,
      statuses_count: statuses_count == freezed
          ? _value.statuses_count
          : statuses_count // ignore: cast_nullable_to_non_nullable
              as int,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      avatar_static: avatar_static == freezed
          ? _value.avatar_static
          : avatar_static // ignore: cast_nullable_to_non_nullable
              as String,
      header: header == freezed
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as String,
      header_static: header_static == freezed
          ? _value.header_static
          : header_static // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$AccountCopyWith(_Account value, $Res Function(_Account) then) =
      __$AccountCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String username,
      String acct,
      String display_name,
      bool locked,
      DateTime created_at,
      int followers_count,
      int following_count,
      int statuses_count,
      String note,
      String url,
      String avatar,
      String avatar_static,
      String header,
      String header_static});
}

/// @nodoc
class __$AccountCopyWithImpl<$Res> extends _$AccountCopyWithImpl<$Res>
    implements _$AccountCopyWith<$Res> {
  __$AccountCopyWithImpl(_Account _value, $Res Function(_Account) _then)
      : super(_value, (v) => _then(v as _Account));

  @override
  _Account get _value => super._value as _Account;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? acct = freezed,
    Object? display_name = freezed,
    Object? locked = freezed,
    Object? created_at = freezed,
    Object? followers_count = freezed,
    Object? following_count = freezed,
    Object? statuses_count = freezed,
    Object? note = freezed,
    Object? url = freezed,
    Object? avatar = freezed,
    Object? avatar_static = freezed,
    Object? header = freezed,
    Object? header_static = freezed,
  }) {
    return _then(_Account(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      acct: acct == freezed
          ? _value.acct
          : acct // ignore: cast_nullable_to_non_nullable
              as String,
      display_name: display_name == freezed
          ? _value.display_name
          : display_name // ignore: cast_nullable_to_non_nullable
              as String,
      locked: locked == freezed
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      followers_count: followers_count == freezed
          ? _value.followers_count
          : followers_count // ignore: cast_nullable_to_non_nullable
              as int,
      following_count: following_count == freezed
          ? _value.following_count
          : following_count // ignore: cast_nullable_to_non_nullable
              as int,
      statuses_count: statuses_count == freezed
          ? _value.statuses_count
          : statuses_count // ignore: cast_nullable_to_non_nullable
              as int,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      avatar_static: avatar_static == freezed
          ? _value.avatar_static
          : avatar_static // ignore: cast_nullable_to_non_nullable
              as String,
      header: header == freezed
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as String,
      header_static: header_static == freezed
          ? _value.header_static
          : header_static // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Account implements _Account {
  _$_Account(
      {required this.id,
      required this.username,
      required this.acct,
      required this.display_name,
      required this.locked,
      required this.created_at,
      required this.followers_count,
      required this.following_count,
      required this.statuses_count,
      required this.note,
      required this.url,
      required this.avatar,
      required this.avatar_static,
      required this.header,
      required this.header_static});

  factory _$_Account.fromJson(Map<String, dynamic> json) =>
      _$$_AccountFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String acct;
  @override
  final String display_name;
  @override
  final bool locked;
  @override
  final DateTime created_at;
  @override
  final int followers_count;
  @override
  final int following_count;
  @override
  final int statuses_count;
  @override
  final String note;
  @override
  final String url;
  @override
  final String avatar;
  @override
  final String avatar_static;
  @override
  final String header;
  @override
  final String header_static;

  @override
  String toString() {
    return 'Account(id: $id, username: $username, acct: $acct, display_name: $display_name, locked: $locked, created_at: $created_at, followers_count: $followers_count, following_count: $following_count, statuses_count: $statuses_count, note: $note, url: $url, avatar: $avatar, avatar_static: $avatar_static, header: $header, header_static: $header_static)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Account &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.acct, acct) &&
            const DeepCollectionEquality()
                .equals(other.display_name, display_name) &&
            const DeepCollectionEquality().equals(other.locked, locked) &&
            const DeepCollectionEquality()
                .equals(other.created_at, created_at) &&
            const DeepCollectionEquality()
                .equals(other.followers_count, followers_count) &&
            const DeepCollectionEquality()
                .equals(other.following_count, following_count) &&
            const DeepCollectionEquality()
                .equals(other.statuses_count, statuses_count) &&
            const DeepCollectionEquality().equals(other.note, note) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            const DeepCollectionEquality()
                .equals(other.avatar_static, avatar_static) &&
            const DeepCollectionEquality().equals(other.header, header) &&
            const DeepCollectionEquality()
                .equals(other.header_static, header_static));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(acct),
      const DeepCollectionEquality().hash(display_name),
      const DeepCollectionEquality().hash(locked),
      const DeepCollectionEquality().hash(created_at),
      const DeepCollectionEquality().hash(followers_count),
      const DeepCollectionEquality().hash(following_count),
      const DeepCollectionEquality().hash(statuses_count),
      const DeepCollectionEquality().hash(note),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(avatar),
      const DeepCollectionEquality().hash(avatar_static),
      const DeepCollectionEquality().hash(header),
      const DeepCollectionEquality().hash(header_static));

  @JsonKey(ignore: true)
  @override
  _$AccountCopyWith<_Account> get copyWith =>
      __$AccountCopyWithImpl<_Account>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccountToJson(this);
  }
}

abstract class _Account implements Account {
  factory _Account(
      {required String id,
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
      required String header_static}) = _$_Account;

  factory _Account.fromJson(Map<String, dynamic> json) = _$_Account.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get acct;
  @override
  String get display_name;
  @override
  bool get locked;
  @override
  DateTime get created_at;
  @override
  int get followers_count;
  @override
  int get following_count;
  @override
  int get statuses_count;
  @override
  String get note;
  @override
  String get url;
  @override
  String get avatar;
  @override
  String get avatar_static;
  @override
  String get header;
  @override
  String get header_static;
  @override
  @JsonKey(ignore: true)
  _$AccountCopyWith<_Account> get copyWith =>
      throw _privateConstructorUsedError;
}

Status _$StatusFromJson(Map<String, dynamic> json) {
  return _Status.fromJson(json);
}

/// @nodoc
class _$StatusTearOff {
  const _$StatusTearOff();

  _Status call(
      {required String id,
      required DateTime created_at,
      String? in_reply_to_id = null,
      String? in_reply_to_account_id = null,
      required bool sensitive,
      required String spoiler_text,
      String? visibility = null,
      Map<String, dynamic>? application = null,
      required Account account,
      required List<dynamic> mentions,
      required List<dynamic> tags,
      required String uri,
      required String content,
      String? url = null,
      required int reblogs_count,
      required int favourites_count,
      Status? reblog = null,
      required bool favourited,
      required bool reblogged}) {
    return _Status(
      id: id,
      created_at: created_at,
      in_reply_to_id: in_reply_to_id,
      in_reply_to_account_id: in_reply_to_account_id,
      sensitive: sensitive,
      spoiler_text: spoiler_text,
      visibility: visibility,
      application: application,
      account: account,
      mentions: mentions,
      tags: tags,
      uri: uri,
      content: content,
      url: url,
      reblogs_count: reblogs_count,
      favourites_count: favourites_count,
      reblog: reblog,
      favourited: favourited,
      reblogged: reblogged,
    );
  }

  Status fromJson(Map<String, Object?> json) {
    return Status.fromJson(json);
  }
}

/// @nodoc
const $Status = _$StatusTearOff();

/// @nodoc
mixin _$Status {
  String get id => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  String? get in_reply_to_id => throw _privateConstructorUsedError;
  String? get in_reply_to_account_id => throw _privateConstructorUsedError;
  bool get sensitive => throw _privateConstructorUsedError;
  String get spoiler_text => throw _privateConstructorUsedError;
  String? get visibility => throw _privateConstructorUsedError;
  Map<String, dynamic>? get application => throw _privateConstructorUsedError;
  Account get account => throw _privateConstructorUsedError;
  List<dynamic> get mentions => throw _privateConstructorUsedError;
  List<dynamic> get tags => throw _privateConstructorUsedError;
  String get uri => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  int get reblogs_count => throw _privateConstructorUsedError;
  int get favourites_count => throw _privateConstructorUsedError;
  Status? get reblog => throw _privateConstructorUsedError; //???
  bool get favourited => throw _privateConstructorUsedError; //???
  bool get reblogged => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusCopyWith<Status> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusCopyWith<$Res> {
  factory $StatusCopyWith(Status value, $Res Function(Status) then) =
      _$StatusCopyWithImpl<$Res>;
  $Res call(
      {String id,
      DateTime created_at,
      String? in_reply_to_id,
      String? in_reply_to_account_id,
      bool sensitive,
      String spoiler_text,
      String? visibility,
      Map<String, dynamic>? application,
      Account account,
      List<dynamic> mentions,
      List<dynamic> tags,
      String uri,
      String content,
      String? url,
      int reblogs_count,
      int favourites_count,
      Status? reblog,
      bool favourited,
      bool reblogged});

  $AccountCopyWith<$Res> get account;
  $StatusCopyWith<$Res>? get reblog;
}

/// @nodoc
class _$StatusCopyWithImpl<$Res> implements $StatusCopyWith<$Res> {
  _$StatusCopyWithImpl(this._value, this._then);

  final Status _value;
  // ignore: unused_field
  final $Res Function(Status) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? created_at = freezed,
    Object? in_reply_to_id = freezed,
    Object? in_reply_to_account_id = freezed,
    Object? sensitive = freezed,
    Object? spoiler_text = freezed,
    Object? visibility = freezed,
    Object? application = freezed,
    Object? account = freezed,
    Object? mentions = freezed,
    Object? tags = freezed,
    Object? uri = freezed,
    Object? content = freezed,
    Object? url = freezed,
    Object? reblogs_count = freezed,
    Object? favourites_count = freezed,
    Object? reblog = freezed,
    Object? favourited = freezed,
    Object? reblogged = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      in_reply_to_id: in_reply_to_id == freezed
          ? _value.in_reply_to_id
          : in_reply_to_id // ignore: cast_nullable_to_non_nullable
              as String?,
      in_reply_to_account_id: in_reply_to_account_id == freezed
          ? _value.in_reply_to_account_id
          : in_reply_to_account_id // ignore: cast_nullable_to_non_nullable
              as String?,
      sensitive: sensitive == freezed
          ? _value.sensitive
          : sensitive // ignore: cast_nullable_to_non_nullable
              as bool,
      spoiler_text: spoiler_text == freezed
          ? _value.spoiler_text
          : spoiler_text // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: visibility == freezed
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      application: application == freezed
          ? _value.application
          : application // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account,
      mentions: mentions == freezed
          ? _value.mentions
          : mentions // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      reblogs_count: reblogs_count == freezed
          ? _value.reblogs_count
          : reblogs_count // ignore: cast_nullable_to_non_nullable
              as int,
      favourites_count: favourites_count == freezed
          ? _value.favourites_count
          : favourites_count // ignore: cast_nullable_to_non_nullable
              as int,
      reblog: reblog == freezed
          ? _value.reblog
          : reblog // ignore: cast_nullable_to_non_nullable
              as Status?,
      favourited: favourited == freezed
          ? _value.favourited
          : favourited // ignore: cast_nullable_to_non_nullable
              as bool,
      reblogged: reblogged == freezed
          ? _value.reblogged
          : reblogged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $AccountCopyWith<$Res> get account {
    return $AccountCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value));
    });
  }

  @override
  $StatusCopyWith<$Res>? get reblog {
    if (_value.reblog == null) {
      return null;
    }

    return $StatusCopyWith<$Res>(_value.reblog!, (value) {
      return _then(_value.copyWith(reblog: value));
    });
  }
}

/// @nodoc
abstract class _$StatusCopyWith<$Res> implements $StatusCopyWith<$Res> {
  factory _$StatusCopyWith(_Status value, $Res Function(_Status) then) =
      __$StatusCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      DateTime created_at,
      String? in_reply_to_id,
      String? in_reply_to_account_id,
      bool sensitive,
      String spoiler_text,
      String? visibility,
      Map<String, dynamic>? application,
      Account account,
      List<dynamic> mentions,
      List<dynamic> tags,
      String uri,
      String content,
      String? url,
      int reblogs_count,
      int favourites_count,
      Status? reblog,
      bool favourited,
      bool reblogged});

  @override
  $AccountCopyWith<$Res> get account;
  @override
  $StatusCopyWith<$Res>? get reblog;
}

/// @nodoc
class __$StatusCopyWithImpl<$Res> extends _$StatusCopyWithImpl<$Res>
    implements _$StatusCopyWith<$Res> {
  __$StatusCopyWithImpl(_Status _value, $Res Function(_Status) _then)
      : super(_value, (v) => _then(v as _Status));

  @override
  _Status get _value => super._value as _Status;

  @override
  $Res call({
    Object? id = freezed,
    Object? created_at = freezed,
    Object? in_reply_to_id = freezed,
    Object? in_reply_to_account_id = freezed,
    Object? sensitive = freezed,
    Object? spoiler_text = freezed,
    Object? visibility = freezed,
    Object? application = freezed,
    Object? account = freezed,
    Object? mentions = freezed,
    Object? tags = freezed,
    Object? uri = freezed,
    Object? content = freezed,
    Object? url = freezed,
    Object? reblogs_count = freezed,
    Object? favourites_count = freezed,
    Object? reblog = freezed,
    Object? favourited = freezed,
    Object? reblogged = freezed,
  }) {
    return _then(_Status(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      in_reply_to_id: in_reply_to_id == freezed
          ? _value.in_reply_to_id
          : in_reply_to_id // ignore: cast_nullable_to_non_nullable
              as String?,
      in_reply_to_account_id: in_reply_to_account_id == freezed
          ? _value.in_reply_to_account_id
          : in_reply_to_account_id // ignore: cast_nullable_to_non_nullable
              as String?,
      sensitive: sensitive == freezed
          ? _value.sensitive
          : sensitive // ignore: cast_nullable_to_non_nullable
              as bool,
      spoiler_text: spoiler_text == freezed
          ? _value.spoiler_text
          : spoiler_text // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: visibility == freezed
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      application: application == freezed
          ? _value.application
          : application // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account,
      mentions: mentions == freezed
          ? _value.mentions
          : mentions // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      reblogs_count: reblogs_count == freezed
          ? _value.reblogs_count
          : reblogs_count // ignore: cast_nullable_to_non_nullable
              as int,
      favourites_count: favourites_count == freezed
          ? _value.favourites_count
          : favourites_count // ignore: cast_nullable_to_non_nullable
              as int,
      reblog: reblog == freezed
          ? _value.reblog
          : reblog // ignore: cast_nullable_to_non_nullable
              as Status?,
      favourited: favourited == freezed
          ? _value.favourited
          : favourited // ignore: cast_nullable_to_non_nullable
              as bool,
      reblogged: reblogged == freezed
          ? _value.reblogged
          : reblogged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Status implements _Status {
  _$_Status(
      {required this.id,
      required this.created_at,
      this.in_reply_to_id = null,
      this.in_reply_to_account_id = null,
      required this.sensitive,
      required this.spoiler_text,
      this.visibility = null,
      this.application = null,
      required this.account,
      required this.mentions,
      required this.tags,
      required this.uri,
      required this.content,
      this.url = null,
      required this.reblogs_count,
      required this.favourites_count,
      this.reblog = null,
      required this.favourited,
      required this.reblogged});

  factory _$_Status.fromJson(Map<String, dynamic> json) =>
      _$$_StatusFromJson(json);

  @override
  final String id;
  @override
  final DateTime created_at;
  @JsonKey()
  @override
  final String? in_reply_to_id;
  @JsonKey()
  @override
  final String? in_reply_to_account_id;
  @override
  final bool sensitive;
  @override
  final String spoiler_text;
  @JsonKey()
  @override
  final String? visibility;
  @JsonKey()
  @override
  final Map<String, dynamic>? application;
  @override
  final Account account;
  @override
  final List<dynamic> mentions;
  @override
  final List<dynamic> tags;
  @override
  final String uri;
  @override
  final String content;
  @JsonKey()
  @override
  final String? url;
  @override
  final int reblogs_count;
  @override
  final int favourites_count;
  @JsonKey()
  @override
  final Status? reblog;
  @override //???
  final bool favourited;
  @override //???
  final bool reblogged;

  @override
  String toString() {
    return 'Status(id: $id, created_at: $created_at, in_reply_to_id: $in_reply_to_id, in_reply_to_account_id: $in_reply_to_account_id, sensitive: $sensitive, spoiler_text: $spoiler_text, visibility: $visibility, application: $application, account: $account, mentions: $mentions, tags: $tags, uri: $uri, content: $content, url: $url, reblogs_count: $reblogs_count, favourites_count: $favourites_count, reblog: $reblog, favourited: $favourited, reblogged: $reblogged)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Status &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.created_at, created_at) &&
            const DeepCollectionEquality()
                .equals(other.in_reply_to_id, in_reply_to_id) &&
            const DeepCollectionEquality()
                .equals(other.in_reply_to_account_id, in_reply_to_account_id) &&
            const DeepCollectionEquality().equals(other.sensitive, sensitive) &&
            const DeepCollectionEquality()
                .equals(other.spoiler_text, spoiler_text) &&
            const DeepCollectionEquality()
                .equals(other.visibility, visibility) &&
            const DeepCollectionEquality()
                .equals(other.application, application) &&
            const DeepCollectionEquality().equals(other.account, account) &&
            const DeepCollectionEquality().equals(other.mentions, mentions) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.uri, uri) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.reblogs_count, reblogs_count) &&
            const DeepCollectionEquality()
                .equals(other.favourites_count, favourites_count) &&
            const DeepCollectionEquality().equals(other.reblog, reblog) &&
            const DeepCollectionEquality()
                .equals(other.favourited, favourited) &&
            const DeepCollectionEquality().equals(other.reblogged, reblogged));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(created_at),
        const DeepCollectionEquality().hash(in_reply_to_id),
        const DeepCollectionEquality().hash(in_reply_to_account_id),
        const DeepCollectionEquality().hash(sensitive),
        const DeepCollectionEquality().hash(spoiler_text),
        const DeepCollectionEquality().hash(visibility),
        const DeepCollectionEquality().hash(application),
        const DeepCollectionEquality().hash(account),
        const DeepCollectionEquality().hash(mentions),
        const DeepCollectionEquality().hash(tags),
        const DeepCollectionEquality().hash(uri),
        const DeepCollectionEquality().hash(content),
        const DeepCollectionEquality().hash(url),
        const DeepCollectionEquality().hash(reblogs_count),
        const DeepCollectionEquality().hash(favourites_count),
        const DeepCollectionEquality().hash(reblog),
        const DeepCollectionEquality().hash(favourited),
        const DeepCollectionEquality().hash(reblogged)
      ]);

  @JsonKey(ignore: true)
  @override
  _$StatusCopyWith<_Status> get copyWith =>
      __$StatusCopyWithImpl<_Status>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StatusToJson(this);
  }
}

abstract class _Status implements Status {
  factory _Status(
      {required String id,
      required DateTime created_at,
      String? in_reply_to_id,
      String? in_reply_to_account_id,
      required bool sensitive,
      required String spoiler_text,
      String? visibility,
      Map<String, dynamic>? application,
      required Account account,
      required List<dynamic> mentions,
      required List<dynamic> tags,
      required String uri,
      required String content,
      String? url,
      required int reblogs_count,
      required int favourites_count,
      Status? reblog,
      required bool favourited,
      required bool reblogged}) = _$_Status;

  factory _Status.fromJson(Map<String, dynamic> json) = _$_Status.fromJson;

  @override
  String get id;
  @override
  DateTime get created_at;
  @override
  String? get in_reply_to_id;
  @override
  String? get in_reply_to_account_id;
  @override
  bool get sensitive;
  @override
  String get spoiler_text;
  @override
  String? get visibility;
  @override
  Map<String, dynamic>? get application;
  @override
  Account get account;
  @override
  List<dynamic> get mentions;
  @override
  List<dynamic> get tags;
  @override
  String get uri;
  @override
  String get content;
  @override
  String? get url;
  @override
  int get reblogs_count;
  @override
  int get favourites_count;
  @override
  Status? get reblog;
  @override //???
  bool get favourited;
  @override //???
  bool get reblogged;
  @override
  @JsonKey(ignore: true)
  _$StatusCopyWith<_Status> get copyWith => throw _privateConstructorUsedError;
}

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
class _$PostTearOff {
  const _$PostTearOff();

  _Post call(
      {required String status,
      int? in_reply_to_id = null,
      List<dynamic>? media_ids = null,
      bool? sensitivity = false,
      String? visibility = 'public',
      String? spoiler_text = null}) {
    return _Post(
      status: status,
      in_reply_to_id: in_reply_to_id,
      media_ids: media_ids,
      sensitivity: sensitivity,
      visibility: visibility,
      spoiler_text: spoiler_text,
    );
  }

  Post fromJson(Map<String, Object?> json) {
    return Post.fromJson(json);
  }
}

/// @nodoc
const $Post = _$PostTearOff();

/// @nodoc
mixin _$Post {
  String get status => throw _privateConstructorUsedError;
  int? get in_reply_to_id => throw _privateConstructorUsedError;
  List<dynamic>? get media_ids => throw _privateConstructorUsedError;
  bool? get sensitivity => throw _privateConstructorUsedError;
  String? get visibility => throw _privateConstructorUsedError;
  String? get spoiler_text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res>;
  $Res call(
      {String status,
      int? in_reply_to_id,
      List<dynamic>? media_ids,
      bool? sensitivity,
      String? visibility,
      String? spoiler_text});
}

/// @nodoc
class _$PostCopyWithImpl<$Res> implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  final Post _value;
  // ignore: unused_field
  final $Res Function(Post) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? in_reply_to_id = freezed,
    Object? media_ids = freezed,
    Object? sensitivity = freezed,
    Object? visibility = freezed,
    Object? spoiler_text = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      in_reply_to_id: in_reply_to_id == freezed
          ? _value.in_reply_to_id
          : in_reply_to_id // ignore: cast_nullable_to_non_nullable
              as int?,
      media_ids: media_ids == freezed
          ? _value.media_ids
          : media_ids // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      sensitivity: sensitivity == freezed
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as bool?,
      visibility: visibility == freezed
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      spoiler_text: spoiler_text == freezed
          ? _value.spoiler_text
          : spoiler_text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) then) =
      __$PostCopyWithImpl<$Res>;
  @override
  $Res call(
      {String status,
      int? in_reply_to_id,
      List<dynamic>? media_ids,
      bool? sensitivity,
      String? visibility,
      String? spoiler_text});
}

/// @nodoc
class __$PostCopyWithImpl<$Res> extends _$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(_Post _value, $Res Function(_Post) _then)
      : super(_value, (v) => _then(v as _Post));

  @override
  _Post get _value => super._value as _Post;

  @override
  $Res call({
    Object? status = freezed,
    Object? in_reply_to_id = freezed,
    Object? media_ids = freezed,
    Object? sensitivity = freezed,
    Object? visibility = freezed,
    Object? spoiler_text = freezed,
  }) {
    return _then(_Post(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      in_reply_to_id: in_reply_to_id == freezed
          ? _value.in_reply_to_id
          : in_reply_to_id // ignore: cast_nullable_to_non_nullable
              as int?,
      media_ids: media_ids == freezed
          ? _value.media_ids
          : media_ids // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      sensitivity: sensitivity == freezed
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as bool?,
      visibility: visibility == freezed
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      spoiler_text: spoiler_text == freezed
          ? _value.spoiler_text
          : spoiler_text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Post implements _Post {
  _$_Post(
      {required this.status,
      this.in_reply_to_id = null,
      this.media_ids = null,
      this.sensitivity = false,
      this.visibility = 'public',
      this.spoiler_text = null});

  factory _$_Post.fromJson(Map<String, dynamic> json) => _$$_PostFromJson(json);

  @override
  final String status;
  @JsonKey()
  @override
  final int? in_reply_to_id;
  @JsonKey()
  @override
  final List<dynamic>? media_ids;
  @JsonKey()
  @override
  final bool? sensitivity;
  @JsonKey()
  @override
  final String? visibility;
  @JsonKey()
  @override
  final String? spoiler_text;

  @override
  String toString() {
    return 'Post(status: $status, in_reply_to_id: $in_reply_to_id, media_ids: $media_ids, sensitivity: $sensitivity, visibility: $visibility, spoiler_text: $spoiler_text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Post &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.in_reply_to_id, in_reply_to_id) &&
            const DeepCollectionEquality().equals(other.media_ids, media_ids) &&
            const DeepCollectionEquality()
                .equals(other.sensitivity, sensitivity) &&
            const DeepCollectionEquality()
                .equals(other.visibility, visibility) &&
            const DeepCollectionEquality()
                .equals(other.spoiler_text, spoiler_text));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(in_reply_to_id),
      const DeepCollectionEquality().hash(media_ids),
      const DeepCollectionEquality().hash(sensitivity),
      const DeepCollectionEquality().hash(visibility),
      const DeepCollectionEquality().hash(spoiler_text));

  @JsonKey(ignore: true)
  @override
  _$PostCopyWith<_Post> get copyWith =>
      __$PostCopyWithImpl<_Post>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostToJson(this);
  }
}

abstract class _Post implements Post {
  factory _Post(
      {required String status,
      int? in_reply_to_id,
      List<dynamic>? media_ids,
      bool? sensitivity,
      String? visibility,
      String? spoiler_text}) = _$_Post;

  factory _Post.fromJson(Map<String, dynamic> json) = _$_Post.fromJson;

  @override
  String get status;
  @override
  int? get in_reply_to_id;
  @override
  List<dynamic>? get media_ids;
  @override
  bool? get sensitivity;
  @override
  String? get visibility;
  @override
  String? get spoiler_text;
  @override
  @JsonKey(ignore: true)
  _$PostCopyWith<_Post> get copyWith => throw _privateConstructorUsedError;
}

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return _Notification.fromJson(json);
}

/// @nodoc
class _$NotificationTearOff {
  const _$NotificationTearOff();

  _Notification call(
      {required int id,
      required String type,
      required DateTime created_at,
      required Account account,
      required Status status}) {
    return _Notification(
      id: id,
      type: type,
      created_at: created_at,
      account: account,
      status: status,
    );
  }

  Notification fromJson(Map<String, Object?> json) {
    return Notification.fromJson(json);
  }
}

/// @nodoc
const $Notification = _$NotificationTearOff();

/// @nodoc
mixin _$Notification {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  Account get account => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationCopyWith<Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String type,
      DateTime created_at,
      Account account,
      Status status});

  $AccountCopyWith<$Res> get account;
  $StatusCopyWith<$Res> get status;
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res> implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  final Notification _value;
  // ignore: unused_field
  final $Res Function(Notification) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? created_at = freezed,
    Object? account = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ));
  }

  @override
  $AccountCopyWith<$Res> get account {
    return $AccountCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value));
    });
  }

  @override
  $StatusCopyWith<$Res> get status {
    return $StatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value));
    });
  }
}

/// @nodoc
abstract class _$NotificationCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(
          _Notification value, $Res Function(_Notification) then) =
      __$NotificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String type,
      DateTime created_at,
      Account account,
      Status status});

  @override
  $AccountCopyWith<$Res> get account;
  @override
  $StatusCopyWith<$Res> get status;
}

/// @nodoc
class __$NotificationCopyWithImpl<$Res> extends _$NotificationCopyWithImpl<$Res>
    implements _$NotificationCopyWith<$Res> {
  __$NotificationCopyWithImpl(
      _Notification _value, $Res Function(_Notification) _then)
      : super(_value, (v) => _then(v as _Notification));

  @override
  _Notification get _value => super._value as _Notification;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? created_at = freezed,
    Object? account = freezed,
    Object? status = freezed,
  }) {
    return _then(_Notification(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Notification implements _Notification {
  _$_Notification(
      {required this.id,
      required this.type,
      required this.created_at,
      required this.account,
      required this.status});

  factory _$_Notification.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final DateTime created_at;
  @override
  final Account account;
  @override
  final Status status;

  @override
  String toString() {
    return 'Notification(id: $id, type: $type, created_at: $created_at, account: $account, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Notification &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.created_at, created_at) &&
            const DeepCollectionEquality().equals(other.account, account) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(created_at),
      const DeepCollectionEquality().hash(account),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$NotificationCopyWith<_Notification> get copyWith =>
      __$NotificationCopyWithImpl<_Notification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationToJson(this);
  }
}

abstract class _Notification implements Notification {
  factory _Notification(
      {required int id,
      required String type,
      required DateTime created_at,
      required Account account,
      required Status status}) = _$_Notification;

  factory _Notification.fromJson(Map<String, dynamic> json) =
      _$_Notification.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  DateTime get created_at;
  @override
  Account get account;
  @override
  Status get status;
  @override
  @JsonKey(ignore: true)
  _$NotificationCopyWith<_Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

TimelineRequest _$TimelineRequestFromJson(Map<String, dynamic> json) {
  return _TimelineRequest.fromJson(json);
}

/// @nodoc
class _$TimelineRequestTearOff {
  const _$TimelineRequestTearOff();

  _TimelineRequest call(
      {String? timeline,
      String? hashtag,
      int? max_id,
      DateTime? since_id,
      int? limit}) {
    return _TimelineRequest(
      timeline: timeline,
      hashtag: hashtag,
      max_id: max_id,
      since_id: since_id,
      limit: limit,
    );
  }

  TimelineRequest fromJson(Map<String, Object?> json) {
    return TimelineRequest.fromJson(json);
  }
}

/// @nodoc
const $TimelineRequest = _$TimelineRequestTearOff();

/// @nodoc
mixin _$TimelineRequest {
  String? get timeline => throw _privateConstructorUsedError;
  String? get hashtag => throw _privateConstructorUsedError;
  int? get max_id => throw _privateConstructorUsedError;
  DateTime? get since_id => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimelineRequestCopyWith<TimelineRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineRequestCopyWith<$Res> {
  factory $TimelineRequestCopyWith(
          TimelineRequest value, $Res Function(TimelineRequest) then) =
      _$TimelineRequestCopyWithImpl<$Res>;
  $Res call(
      {String? timeline,
      String? hashtag,
      int? max_id,
      DateTime? since_id,
      int? limit});
}

/// @nodoc
class _$TimelineRequestCopyWithImpl<$Res>
    implements $TimelineRequestCopyWith<$Res> {
  _$TimelineRequestCopyWithImpl(this._value, this._then);

  final TimelineRequest _value;
  // ignore: unused_field
  final $Res Function(TimelineRequest) _then;

  @override
  $Res call({
    Object? timeline = freezed,
    Object? hashtag = freezed,
    Object? max_id = freezed,
    Object? since_id = freezed,
    Object? limit = freezed,
  }) {
    return _then(_value.copyWith(
      timeline: timeline == freezed
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtag: hashtag == freezed
          ? _value.hashtag
          : hashtag // ignore: cast_nullable_to_non_nullable
              as String?,
      max_id: max_id == freezed
          ? _value.max_id
          : max_id // ignore: cast_nullable_to_non_nullable
              as int?,
      since_id: since_id == freezed
          ? _value.since_id
          : since_id // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$TimelineRequestCopyWith<$Res>
    implements $TimelineRequestCopyWith<$Res> {
  factory _$TimelineRequestCopyWith(
          _TimelineRequest value, $Res Function(_TimelineRequest) then) =
      __$TimelineRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? timeline,
      String? hashtag,
      int? max_id,
      DateTime? since_id,
      int? limit});
}

/// @nodoc
class __$TimelineRequestCopyWithImpl<$Res>
    extends _$TimelineRequestCopyWithImpl<$Res>
    implements _$TimelineRequestCopyWith<$Res> {
  __$TimelineRequestCopyWithImpl(
      _TimelineRequest _value, $Res Function(_TimelineRequest) _then)
      : super(_value, (v) => _then(v as _TimelineRequest));

  @override
  _TimelineRequest get _value => super._value as _TimelineRequest;

  @override
  $Res call({
    Object? timeline = freezed,
    Object? hashtag = freezed,
    Object? max_id = freezed,
    Object? since_id = freezed,
    Object? limit = freezed,
  }) {
    return _then(_TimelineRequest(
      timeline: timeline == freezed
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String?,
      hashtag: hashtag == freezed
          ? _value.hashtag
          : hashtag // ignore: cast_nullable_to_non_nullable
              as String?,
      max_id: max_id == freezed
          ? _value.max_id
          : max_id // ignore: cast_nullable_to_non_nullable
              as int?,
      since_id: since_id == freezed
          ? _value.since_id
          : since_id // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TimelineRequest implements _TimelineRequest {
  _$_TimelineRequest(
      {this.timeline, this.hashtag, this.max_id, this.since_id, this.limit});

  factory _$_TimelineRequest.fromJson(Map<String, dynamic> json) =>
      _$$_TimelineRequestFromJson(json);

  @override
  final String? timeline;
  @override
  final String? hashtag;
  @override
  final int? max_id;
  @override
  final DateTime? since_id;
  @override
  final int? limit;

  @override
  String toString() {
    return 'TimelineRequest(timeline: $timeline, hashtag: $hashtag, max_id: $max_id, since_id: $since_id, limit: $limit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimelineRequest &&
            const DeepCollectionEquality().equals(other.timeline, timeline) &&
            const DeepCollectionEquality().equals(other.hashtag, hashtag) &&
            const DeepCollectionEquality().equals(other.max_id, max_id) &&
            const DeepCollectionEquality().equals(other.since_id, since_id) &&
            const DeepCollectionEquality().equals(other.limit, limit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timeline),
      const DeepCollectionEquality().hash(hashtag),
      const DeepCollectionEquality().hash(max_id),
      const DeepCollectionEquality().hash(since_id),
      const DeepCollectionEquality().hash(limit));

  @JsonKey(ignore: true)
  @override
  _$TimelineRequestCopyWith<_TimelineRequest> get copyWith =>
      __$TimelineRequestCopyWithImpl<_TimelineRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimelineRequestToJson(this);
  }
}

abstract class _TimelineRequest implements TimelineRequest {
  factory _TimelineRequest(
      {String? timeline,
      String? hashtag,
      int? max_id,
      DateTime? since_id,
      int? limit}) = _$_TimelineRequest;

  factory _TimelineRequest.fromJson(Map<String, dynamic> json) =
      _$_TimelineRequest.fromJson;

  @override
  String? get timeline;
  @override
  String? get hashtag;
  @override
  int? get max_id;
  @override
  DateTime? get since_id;
  @override
  int? get limit;
  @override
  @JsonKey(ignore: true)
  _$TimelineRequestCopyWith<_TimelineRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

Relationship _$RelationshipFromJson(Map<String, dynamic> json) {
  return _Relationship.fromJson(json);
}

/// @nodoc
class _$RelationshipTearOff {
  const _$RelationshipTearOff();

  _Relationship call(
      {required int id,
      required bool following,
      required bool followed_by,
      required bool blocking,
      required bool muting,
      required bool requested}) {
    return _Relationship(
      id: id,
      following: following,
      followed_by: followed_by,
      blocking: blocking,
      muting: muting,
      requested: requested,
    );
  }

  Relationship fromJson(Map<String, Object?> json) {
    return Relationship.fromJson(json);
  }
}

/// @nodoc
const $Relationship = _$RelationshipTearOff();

/// @nodoc
mixin _$Relationship {
  int get id => throw _privateConstructorUsedError;
  bool get following => throw _privateConstructorUsedError;
  bool get followed_by => throw _privateConstructorUsedError;
  bool get blocking => throw _privateConstructorUsedError;
  bool get muting => throw _privateConstructorUsedError;
  bool get requested => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RelationshipCopyWith<Relationship> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelationshipCopyWith<$Res> {
  factory $RelationshipCopyWith(
          Relationship value, $Res Function(Relationship) then) =
      _$RelationshipCopyWithImpl<$Res>;
  $Res call(
      {int id,
      bool following,
      bool followed_by,
      bool blocking,
      bool muting,
      bool requested});
}

/// @nodoc
class _$RelationshipCopyWithImpl<$Res> implements $RelationshipCopyWith<$Res> {
  _$RelationshipCopyWithImpl(this._value, this._then);

  final Relationship _value;
  // ignore: unused_field
  final $Res Function(Relationship) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? following = freezed,
    Object? followed_by = freezed,
    Object? blocking = freezed,
    Object? muting = freezed,
    Object? requested = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as bool,
      followed_by: followed_by == freezed
          ? _value.followed_by
          : followed_by // ignore: cast_nullable_to_non_nullable
              as bool,
      blocking: blocking == freezed
          ? _value.blocking
          : blocking // ignore: cast_nullable_to_non_nullable
              as bool,
      muting: muting == freezed
          ? _value.muting
          : muting // ignore: cast_nullable_to_non_nullable
              as bool,
      requested: requested == freezed
          ? _value.requested
          : requested // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$RelationshipCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$RelationshipCopyWith(
          _Relationship value, $Res Function(_Relationship) then) =
      __$RelationshipCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      bool following,
      bool followed_by,
      bool blocking,
      bool muting,
      bool requested});
}

/// @nodoc
class __$RelationshipCopyWithImpl<$Res> extends _$RelationshipCopyWithImpl<$Res>
    implements _$RelationshipCopyWith<$Res> {
  __$RelationshipCopyWithImpl(
      _Relationship _value, $Res Function(_Relationship) _then)
      : super(_value, (v) => _then(v as _Relationship));

  @override
  _Relationship get _value => super._value as _Relationship;

  @override
  $Res call({
    Object? id = freezed,
    Object? following = freezed,
    Object? followed_by = freezed,
    Object? blocking = freezed,
    Object? muting = freezed,
    Object? requested = freezed,
  }) {
    return _then(_Relationship(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as bool,
      followed_by: followed_by == freezed
          ? _value.followed_by
          : followed_by // ignore: cast_nullable_to_non_nullable
              as bool,
      blocking: blocking == freezed
          ? _value.blocking
          : blocking // ignore: cast_nullable_to_non_nullable
              as bool,
      muting: muting == freezed
          ? _value.muting
          : muting // ignore: cast_nullable_to_non_nullable
              as bool,
      requested: requested == freezed
          ? _value.requested
          : requested // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Relationship implements _Relationship {
  _$_Relationship(
      {required this.id,
      required this.following,
      required this.followed_by,
      required this.blocking,
      required this.muting,
      required this.requested});

  factory _$_Relationship.fromJson(Map<String, dynamic> json) =>
      _$$_RelationshipFromJson(json);

  @override
  final int id;
  @override
  final bool following;
  @override
  final bool followed_by;
  @override
  final bool blocking;
  @override
  final bool muting;
  @override
  final bool requested;

  @override
  String toString() {
    return 'Relationship(id: $id, following: $following, followed_by: $followed_by, blocking: $blocking, muting: $muting, requested: $requested)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Relationship &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.following, following) &&
            const DeepCollectionEquality()
                .equals(other.followed_by, followed_by) &&
            const DeepCollectionEquality().equals(other.blocking, blocking) &&
            const DeepCollectionEquality().equals(other.muting, muting) &&
            const DeepCollectionEquality().equals(other.requested, requested));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(following),
      const DeepCollectionEquality().hash(followed_by),
      const DeepCollectionEquality().hash(blocking),
      const DeepCollectionEquality().hash(muting),
      const DeepCollectionEquality().hash(requested));

  @JsonKey(ignore: true)
  @override
  _$RelationshipCopyWith<_Relationship> get copyWith =>
      __$RelationshipCopyWithImpl<_Relationship>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RelationshipToJson(this);
  }
}

abstract class _Relationship implements Relationship {
  factory _Relationship(
      {required int id,
      required bool following,
      required bool followed_by,
      required bool blocking,
      required bool muting,
      required bool requested}) = _$_Relationship;

  factory _Relationship.fromJson(Map<String, dynamic> json) =
      _$_Relationship.fromJson;

  @override
  int get id;
  @override
  bool get following;
  @override
  bool get followed_by;
  @override
  bool get blocking;
  @override
  bool get muting;
  @override
  bool get requested;
  @override
  @JsonKey(ignore: true)
  _$RelationshipCopyWith<_Relationship> get copyWith =>
      throw _privateConstructorUsedError;
}

Report _$ReportFromJson(Map<String, dynamic> json) {
  return _Report.fromJson(json);
}

/// @nodoc
class _$ReportTearOff {
  const _$ReportTearOff();

  _Report call({required int id, required String action_taken}) {
    return _Report(
      id: id,
      action_taken: action_taken,
    );
  }

  Report fromJson(Map<String, Object?> json) {
    return Report.fromJson(json);
  }
}

/// @nodoc
const $Report = _$ReportTearOff();

/// @nodoc
mixin _$Report {
  int get id => throw _privateConstructorUsedError;
  String get action_taken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportCopyWith<Report> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportCopyWith<$Res> {
  factory $ReportCopyWith(Report value, $Res Function(Report) then) =
      _$ReportCopyWithImpl<$Res>;
  $Res call({int id, String action_taken});
}

/// @nodoc
class _$ReportCopyWithImpl<$Res> implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._value, this._then);

  final Report _value;
  // ignore: unused_field
  final $Res Function(Report) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? action_taken = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      action_taken: action_taken == freezed
          ? _value.action_taken
          : action_taken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ReportCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$ReportCopyWith(_Report value, $Res Function(_Report) then) =
      __$ReportCopyWithImpl<$Res>;
  @override
  $Res call({int id, String action_taken});
}

/// @nodoc
class __$ReportCopyWithImpl<$Res> extends _$ReportCopyWithImpl<$Res>
    implements _$ReportCopyWith<$Res> {
  __$ReportCopyWithImpl(_Report _value, $Res Function(_Report) _then)
      : super(_value, (v) => _then(v as _Report));

  @override
  _Report get _value => super._value as _Report;

  @override
  $Res call({
    Object? id = freezed,
    Object? action_taken = freezed,
  }) {
    return _then(_Report(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      action_taken: action_taken == freezed
          ? _value.action_taken
          : action_taken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Report implements _Report {
  _$_Report({required this.id, required this.action_taken});

  factory _$_Report.fromJson(Map<String, dynamic> json) =>
      _$$_ReportFromJson(json);

  @override
  final int id;
  @override
  final String action_taken;

  @override
  String toString() {
    return 'Report(id: $id, action_taken: $action_taken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Report &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.action_taken, action_taken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(action_taken));

  @JsonKey(ignore: true)
  @override
  _$ReportCopyWith<_Report> get copyWith =>
      __$ReportCopyWithImpl<_Report>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReportToJson(this);
  }
}

abstract class _Report implements Report {
  factory _Report({required int id, required String action_taken}) = _$_Report;

  factory _Report.fromJson(Map<String, dynamic> json) = _$_Report.fromJson;

  @override
  int get id;
  @override
  String get action_taken;
  @override
  @JsonKey(ignore: true)
  _$ReportCopyWith<_Report> get copyWith => throw _privateConstructorUsedError;
}

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return _Attachment.fromJson(json);
}

/// @nodoc
class _$AttachmentTearOff {
  const _$AttachmentTearOff();

  _Attachment call(
      {required int id,
      required String type,
      required String url,
      required String remote_url,
      required String preview_url,
      required String text_url}) {
    return _Attachment(
      id: id,
      type: type,
      url: url,
      remote_url: remote_url,
      preview_url: preview_url,
      text_url: text_url,
    );
  }

  Attachment fromJson(Map<String, Object?> json) {
    return Attachment.fromJson(json);
  }
}

/// @nodoc
const $Attachment = _$AttachmentTearOff();

/// @nodoc
mixin _$Attachment {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get remote_url => throw _privateConstructorUsedError;
  String get preview_url => throw _privateConstructorUsedError;
  String get text_url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
          Attachment value, $Res Function(Attachment) then) =
      _$AttachmentCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String type,
      String url,
      String remote_url,
      String preview_url,
      String text_url});
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res> implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  final Attachment _value;
  // ignore: unused_field
  final $Res Function(Attachment) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? url = freezed,
    Object? remote_url = freezed,
    Object? preview_url = freezed,
    Object? text_url = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      remote_url: remote_url == freezed
          ? _value.remote_url
          : remote_url // ignore: cast_nullable_to_non_nullable
              as String,
      preview_url: preview_url == freezed
          ? _value.preview_url
          : preview_url // ignore: cast_nullable_to_non_nullable
              as String,
      text_url: text_url == freezed
          ? _value.text_url
          : text_url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AttachmentCopyWith<$Res> implements $AttachmentCopyWith<$Res> {
  factory _$AttachmentCopyWith(
          _Attachment value, $Res Function(_Attachment) then) =
      __$AttachmentCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String type,
      String url,
      String remote_url,
      String preview_url,
      String text_url});
}

/// @nodoc
class __$AttachmentCopyWithImpl<$Res> extends _$AttachmentCopyWithImpl<$Res>
    implements _$AttachmentCopyWith<$Res> {
  __$AttachmentCopyWithImpl(
      _Attachment _value, $Res Function(_Attachment) _then)
      : super(_value, (v) => _then(v as _Attachment));

  @override
  _Attachment get _value => super._value as _Attachment;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? url = freezed,
    Object? remote_url = freezed,
    Object? preview_url = freezed,
    Object? text_url = freezed,
  }) {
    return _then(_Attachment(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      remote_url: remote_url == freezed
          ? _value.remote_url
          : remote_url // ignore: cast_nullable_to_non_nullable
              as String,
      preview_url: preview_url == freezed
          ? _value.preview_url
          : preview_url // ignore: cast_nullable_to_non_nullable
              as String,
      text_url: text_url == freezed
          ? _value.text_url
          : text_url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Attachment implements _Attachment {
  _$_Attachment(
      {required this.id,
      required this.type,
      required this.url,
      required this.remote_url,
      required this.preview_url,
      required this.text_url});

  factory _$_Attachment.fromJson(Map<String, dynamic> json) =>
      _$$_AttachmentFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final String url;
  @override
  final String remote_url;
  @override
  final String preview_url;
  @override
  final String text_url;

  @override
  String toString() {
    return 'Attachment(id: $id, type: $type, url: $url, remote_url: $remote_url, preview_url: $preview_url, text_url: $text_url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Attachment &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.remote_url, remote_url) &&
            const DeepCollectionEquality()
                .equals(other.preview_url, preview_url) &&
            const DeepCollectionEquality().equals(other.text_url, text_url));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(remote_url),
      const DeepCollectionEquality().hash(preview_url),
      const DeepCollectionEquality().hash(text_url));

  @JsonKey(ignore: true)
  @override
  _$AttachmentCopyWith<_Attachment> get copyWith =>
      __$AttachmentCopyWithImpl<_Attachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttachmentToJson(this);
  }
}

abstract class _Attachment implements Attachment {
  factory _Attachment(
      {required int id,
      required String type,
      required String url,
      required String remote_url,
      required String preview_url,
      required String text_url}) = _$_Attachment;

  factory _Attachment.fromJson(Map<String, dynamic> json) =
      _$_Attachment.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  String get url;
  @override
  String get remote_url;
  @override
  String get preview_url;
  @override
  String get text_url;
  @override
  @JsonKey(ignore: true)
  _$AttachmentCopyWith<_Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}