class HttpExceptionn implements Exception {
  final String? msg;
  final int? statusCode;

  HttpExceptionn( {
    this.statusCode,
    this.msg
});

  @override
  String toString() {
    return msg!;
  }
}