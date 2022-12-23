import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';

@module
@immutable
abstract class DioProvider {
  @singleton
  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
      ),
    )..interceptors.addAll(
        [
          PrettyDioLogger(
            requestBody: true,
            error: true,
            requestHeader: true,
            compact: true,
          ),
        ],
      );
  }
}
