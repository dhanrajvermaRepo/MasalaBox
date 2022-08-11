class MasalaBoxEexception implements Exception {
  const MasalaBoxEexception({this.message, this.errorCode});
  final String? message;
  final int? errorCode;
}
