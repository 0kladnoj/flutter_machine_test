import 'base_exception.dart';

class ApiException extends BaseException {
  final int statusCode;

  const ApiException({
    super.message,
    this.statusCode = -1,
  });

  @override
  String toString() {
    if (statusCode == -1) return message;
    return '[$statusCode]: $message';
  }
}
