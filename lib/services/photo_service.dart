import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../api/retrofit/app_api.dart';
import '../base/service/base_service.dart';
import '../models/photo_item.dart';

@immutable
abstract class PhotoService extends BaseService {
  final AppApi _api;

  const PhotoService(this._api);

  Future<List<PhotoItem>> getPhotos();
}

@Injectable(as: PhotoService, env: [Environment.dev])
class ApiPhotoService extends PhotoService {
  const ApiPhotoService(AppApi api) : super(api);

  @override
  Future<List<PhotoItem>> getPhotos() {
    return makeErrorParsedCall(_api.getPhotos);
  }
}

@Injectable(as: PhotoService, env: [Environment.test])
class TestPhotoService extends PhotoService {
  const TestPhotoService(AppApi api) : super(api);

  @override
  Future<List<PhotoItem>> getPhotos() async {
    return makeErrorParsedCall(() async {
      final file = File('test/json/photos.json').readAsStringSync();
      final map = json.decode(file);
      if (map is! List) return [];
      return map.map((json) => PhotoItem.fromJson(json)).toList();
    });
  }
}
