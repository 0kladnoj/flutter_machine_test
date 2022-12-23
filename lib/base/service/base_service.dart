import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../exceptions/application_exception.dart';
import '../exceptions/api_exception.dart';
import '../exceptions/no_internet_exception.dart';
import 'models/base_error.dart';

@immutable
abstract class BaseService {
  const BaseService();

  Future<T> makeErrorParsedCall<T>(AsyncValueGetter<T> callback) async {
    try {
      return await callback();
    } on DioError catch (exception) {
      throw await _getProcessedDioError(exception);
    } on ApiException {
      rethrow;
    } on ApplicationException {
      rethrow;
    } catch (exception, stackTrace) {
      final error = exception.toString();
      log(
        error,
        name: 'BaseService Error',
        error: exception,
        stackTrace: stackTrace,
      );
      if (exception is String) throw ApplicationException(message: exception);

      throw ApplicationException(message: error);
    }
  }

  Future<ApiException> _getProcessedDioError(DioError exception) async {
    try {
      await InternetAddress.lookup('example.com');
    } on SocketException catch (_) {
      return const NoInternetException(message: 'Error Internet Connection');
    }

    const unknownApiException = ApiException(message: 'Server Error');

    try {
      final response = exception.response?.data;

      if (response == null) {
        return unknownApiException;
      }

      final apiError = BaseError.fromJson(response);

      return ApiException(
        statusCode: apiError.status,
        message: '${apiError.detail} [${apiError.message}]',
      );
    } catch (_) {
      return unknownApiException;
    }
  }
}
