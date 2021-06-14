class AlgoSignerException implements Exception {
  String message;
  dynamic cause;

  AlgoSignerException(this.message, this.cause);
}
