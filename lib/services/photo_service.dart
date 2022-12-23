import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../api/retrofit/app_api.dart';
import '../base/service/base_service.dart';
import '../models/photo_item.dart';

@immutable
@injectable
class PhotoService extends BaseService {
  final AppApi _api;

  const PhotoService(this._api);

  Future<List<PhotoItem>> getPhotos() {
    return makeErrorParsedCall(_api.getPhotos);
  }
}
