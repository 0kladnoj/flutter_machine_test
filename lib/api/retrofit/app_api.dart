import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/photo_item.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @GET('/photos')
  Future<List<PhotoItem>> getPhotos();
}

@module
abstract class AppApiModule {
  @lazySingleton
  AppApi createAppApi(Dio dio) => AppApi(dio);
}
