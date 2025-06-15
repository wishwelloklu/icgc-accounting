class CacheException implements Exception {}

class CustomException implements CacheException {
  String message;
  List<String>? errorAll;
  CustomException(this.message, [this.errorAll]);
}
