import 'connection/elgin_errors.dart';

class ElginException implements Exception {
  int exception;
  late ElginError error;
  ElginException(this.exception) {
    error = ElginError(exception);
  }
}
