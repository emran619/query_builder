class QueryExceptionHandler {
  static Future<void> handler({
    required Future<void> Function() function,
    void Function(String)? whenError,
  }) async {
    try {
      await function.call();
    } catch (e) {
      dynamic exception = e;
      whenError?.call(exception.message);
    }
  }
}
