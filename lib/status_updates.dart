part of 'mastodon.dart';

/// Create new Statuses (Posts) and make updates.
extension extensionStatusUpdates on Mastodon {
  /// Create a new status.
  Future<Status> postStatus(Post status) async {
    final s = status;

    final map = _makeParamMap(s);

    final response =
        Status.fromJson(await _apiRequest('POST', '/api/v1/statuses', map));
    return response;
  }

  /// Convenience method to create a status from text only.
  Future<Status> toot(String text) async =>
      await postStatus(Post.withText(text));

  /// Delete a Toot.
  Future<Status> deleteStatus(String id) async {
    final json = await _apiRequest('DELETE', '/api/v1/statuses/$id');
    // Deleting returns a Status with `text` instead of `content`, so we
    // add an empty `content` rather than mess about with base class.
    json['content'] = '';
    return Status.fromJson(json);
  }

  /// Reblog a Status.
  Future<Status> reblogStatus(String id) async =>
      Status.fromJson(await _apiRequest('POST', '/api/v1/statuses/$id/reblog'));

  /// Un-reblog a Status.
  Future<Status> unreblogStatus(String id) async => Status.fromJson(
      await _apiRequest('POST', '/api/v1/statuses/$id/unreblog'));

  /// Favourite a Status.
  Future<Status> favouriteStatus(String id) async => Status.fromJson(
      await _apiRequest('POST', '/api/v1/statuses/$id/favourite'));

  /// Un-favourite a Status.
  Future<Status> unfavouriteStatus(String id) async => Status.fromJson(
      await _apiRequest('POST', '/api/v1/statuses/$id/unfavourite'));

  /// Post a media item to the server, for later inclusion in a Status.
  ///
  /// Returns: an attachment that can be added to the Status.
  Future<Attachment> postMedia(List<int> media, String mimeType) async {
    if (mimeType.isEmpty)
      throw MastodonIllegalArgumentError('No mime type provided.');

    final date = DateTime.now().toIso8601String();

    // Overkill maybe?
    final r = Random();
    final list = List.generate(10, (i) => r.nextInt(9).toString());
    final randomSuffix = list.join();
    // Will use .data as the extension if it can't find a better one.
    var ext = extensionFromMime(mimeType);
    if (ext == mimeType) ext = 'data';

    final name = 'mastodondartupload${date}_$randomSuffix.$ext';
    final mpf = MultipartFile.fromBytes('file', media,
        filename: name, contentType: MediaType.parse(mimeType));
    return Attachment.fromJson(
        await _apiRequest('POST', '/api/v1/media', {}, {'file': mpf}));
  }

  /// Simpler way of uploading a media item directly from a file.
  Future<Attachment> postMediaFile(String mediaFile) async {
    String? mimeType;
    final resolver = MimeTypeResolver();
    mimeType = resolver.lookup(mediaFile);

    if (mimeType == null)
      throw MastodonIllegalArgumentError('Could not tell mime type of file.');

    final List<int> media = File(mediaFile).readAsBytesSync();

    if (media.isEmpty)
      throw MastodonIllegalArgumentError('Could not read media file.');

    return await postMedia(media, mimeType);
  }
}
