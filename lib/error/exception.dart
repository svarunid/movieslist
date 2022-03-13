class LogInException implements Exception {
  String message;
  LogInException(this.message);

  @override
  String toString() {
    return message;
  }
}
