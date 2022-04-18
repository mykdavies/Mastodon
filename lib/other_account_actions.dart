part of 'mastodon.dart';

/// Updates to other accounts and relationships.
extension extensionOtherAccountActions on Mastodon {
  /// Follow an account.
  Future<Relationship> followAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/follow'));

  /// Unfollow an account.
  Future<Relationship> unfollowAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/unfollow'));

  /// Block an account.
  Future<Relationship> blockAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/block'));

  /// Unblock an account.
  Future<Relationship> unblockAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/unblock'));

  /// Mute an account.
  Future<Relationship> muteAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/mute'));

  /// Unmute an account.
  Future<Relationship> unmuteAccount(int id) async => Relationship.fromJson(
      await _apiRequest('POST', '/api/v1/accounts/$id/unmute'));

  /// Report an account.
  Future<Report> reportAccount(int accountId, List<int> statusIds) async =>
      Report.fromJson(await _apiRequest('POST', '/api/v1/reports',
          _makeParamMap({'account_id': accountId, 'status_ids': statusIds})));

  /// Accept a follow request.
  Future<Account> authoriseFollowRequest(int id) async => Account.fromJson(
      await _apiRequest('POST', '/api/v1/follow_requests/$id/authorize'));

  /// Reject a follow request.
  Future<Account> rejectFollowRequest(int id) async => Account.fromJson(
      await _apiRequest('POST', '/api/v1/follow_requests/$id/reject'));
}
