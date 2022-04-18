part of 'mastodon.dart';

/// Get information about other accounts.
extension extensionOtherAccounts on Mastodon {
  /// Get information about another account. Returns an [Account].
  Future<Account> getAccount(int id) async =>
      Account.fromJson(await _apiRequest('GET', '/api/v1/accounts/$id'));

  /// Get statuses posted by another account. Returns list of [Status].
  Future<List<Status>> getAccountStatuses(int id,
          [TimelineRequest? request]) async =>
      await getTimeline(request ?? TimelineRequest(), id);

  /// Get accounts followed by this one. Returns list of [Account].
  Future<List<Account>> getAccountFollowing(int id) async => [
        for (var a
            in await _apiRequest('GET', '/api/v1/accounts/$id/following'))
          Account.fromJson(a)
      ];

  /// Get followers of this account. Returns list of [Account].
  Future<List<Account>> getAccountFollowers(int id) async => [
        for (var a
            in await _apiRequest('GET', '/api/v1/accounts/$id/followers'))
          Account.fromJson(a)
      ];

  /// Find accounts matching query. Returns list of [Account].
  Future<List<Account>> findAccounts(String query, {int? limit}) async => [
        for (var a in await _apiRequest('GET', '/api/v1/accounts/search',
            _makeParamMap({'q': query, 'limit': limit})))
          Account.fromJson(a)
      ];
}
