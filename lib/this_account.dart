part of 'mastodon.dart';

/// Get information for this account.
extension extensionThisAccount on Mastodon {
  /// Update current account profile.
  /// 'note' is the user's bio. 'avatar' and 'header' are images
  /// encoded in base64, prepended by a content-type
  /// (for example: 'data:image/png;base64,iVBORw0KGgoAAAA[...]')
  Future<Relationship> updateAccount(
          {String displayName: '',
          String note: '',
          String avatar: '',
          String header: ''}) async =>
      Relationship.fromJson(await _apiRequest(
          'POST',
          '/api/v1/accounts/update_credentials',
          _makeParamMap({
            'display_name': displayName,
            'note': note,
            'avatar': avatar,
            'header': header
          })));

  /// Get details of the logged-in [Account].
  dynamic verifyAccount() async => Account.fromJson(
      await _apiRequest('GET', '/api/v1/accounts/verify_credentials'));

  /// Get list of [Account]s with some [Relationship] with this one.
  dynamic getAccountRelationships() async => Account.fromJson(
      await _apiRequest('GET', '/api/v1/accounts/relationships'));

  /// Get list of [Account]s muted by this one.
  dynamic getMutes() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/mutes'));

  /// Get list of [Account]s blocked by this one.
  dynamic getBlocks() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/blocks'));

  /// Get list of [Account]s reported by this one.
  dynamic getReports() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/reports'));

  /// Get list of [Status]es favourited by this one.
  dynamic getFavourites() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/favourites'));

  /// Get list of [Account]s requesting follows of this one.
  dynamic getFollowRequests() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/follow_requests'));

  /// Get list of [Account]s this one follows.
  dynamic getFollows() async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/follows'));

  /// Clear notifications.
  dynamic clearNotifications() async =>
      await _apiRequest('DELETE', '/api/v1/notifications/clear');
}
