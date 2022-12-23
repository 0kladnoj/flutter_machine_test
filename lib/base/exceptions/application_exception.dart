import 'base_exception.dart';

class ApplicationException extends BaseException {
  const ApplicationException({super.message});

  @override
  String toString() => message;
}
