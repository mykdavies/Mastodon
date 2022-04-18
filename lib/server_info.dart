part of 'mastodon.dart';

/// Get information for this account.
extension extensionServerInfo on Mastodon {
  //
  // Get general information.
  //

  /// Get information about this server.
  dynamic getInstance() async => await _apiRequest('GET', '/api/v1/instance/');

  /// Fetch statuses, most recent ones first. Timeline can be home, local, public,
  /// or tag/hashtag. See the following functions' documentation for what those do.
  /// The default timeline is the "home" timeline.
  /// Returns a list of Status dicts.
  Future<List<Status>> getTimeline(TimelineRequest request, [int? id]) async {
    final map = _makeParamMap(request);

    var tl = request.timeline ?? '';
    if (tl == 'local') {
      tl = 'public';
      map['local'] = 'true';
    } else if (tl == 'hashtag') {
      tl = 'tag/${request.hashtag}';
    }
    map.remove('hashtag'); // The code above handles hashtags.

    var json;
    if (id == null) {
      json = await _apiRequest('GET', '/api/v1/timelines/$tl', map);
    } else {
      json = await _apiRequest('GET', '/api/v1/accounts/$id/statuses', map);
    }

    final list = <Status>[for (var s in json) Status.fromJson(s)];

    return list;
  }

  /// Get list of notifications (= mentions, favourites, reblogs, follows).
  dynamic getNotifications([String id = '']) async => Notification.fromJson(
      await _apiRequest('GET', '/api/v1/notifications/$id'));

  /// Fetch matching hashtags, accounts and statuses.
  /// Will search federated instances if resolve is True.
  /// Returns a map holding [Account]s, [Status]es, and (String) hashtags.
  dynamic find(String query, {bool resolve: false}) async {
    final map = await _apiRequest('GET', '/api/v1/search',
        _makeParamMap({'q': query, 'resolve': resolve}));
    map['accounts'] = Account.fromJson(map['accounts']);
    map['statuses'] = Account.fromJson(map['statuses']);
    map['hashtags'] = Account.fromJson(map['hashtags']);
    return map;
  }
}
