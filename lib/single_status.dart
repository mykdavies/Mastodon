part of 'mastodon.dart';

/// Get information about a single Status.
extension extensionSingleStatus on Mastodon {
  /// Get a single toot by id.
  Future<Status> getStatus(String id) async =>
      Status.fromJson(await _apiRequest('GET', '/api/v1/statuses/$id'));

  /// Get a single status card by id.
  Future<Status> getStatusCard(String id) async =>
      Status.fromJson(await _apiRequest('GET', '/api/v1/statuses/$id/card'));

  /// Get ancestors and descendants of a single toot.
  Future<Status> getStatusContext(String id) async =>
      Status.fromJson(await _apiRequest('GET', '/api/v1/statuses/$id/context'));

  /// Get list of users who have boosted this.
  Future<Account> getStatusRebloggedBy(String id) async => Account.fromJson(
      await _apiRequest('GET', '/api/v1/statuses/$id/reblogged_by'));

  /// Get list of users who have favourited this.
  Future<Account> getStatusFavouritedBy(String id) async => Account.fromJson(
      await _apiRequest('GET', '/api/v1/statuses/$id/favourited_by'));
}
