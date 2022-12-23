import 'base_exception.dart';

class UnknownException extends BaseException {
  @override
  String get message => 'Unknown Exception: ${super.message}';

  const UnknownException(String message) : super(message: message);
}
