// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_machine_test/api/retrofit/app_api.dart' as _i4;
import 'package:flutter_machine_test/bloc/home/home_bloc.dart' as _i6;
import 'package:flutter_machine_test/services/photo_service.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/dio/dio_provider.dart' as _i8;
import '../api/retrofit/app_api.dart' as _i7;

const String _dev = 'dev';
const String _test = 'test';

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dioProvider = _$DioProvider();
  final appApiModule = _$AppApiModule();
  gh.singleton<_i3.Dio>(dioProvider.dio());
  gh.lazySingleton<_i4.AppApi>(() => appApiModule.createAppApi(gh<_i3.Dio>()));
  gh.factory<_i5.PhotoService>(
    () => _i5.ApiPhotoService(gh<_i4.AppApi>()),
    registerFor: {_dev},
  );
  gh.factory<_i5.PhotoService>(
    () => _i5.TestPhotoService(gh<_i4.AppApi>()),
    registerFor: {_test},
  );
  gh.factory<_i6.HomeBloc>(() => _i6.HomeBloc(gh<_i5.PhotoService>()));
  return getIt;
}

class _$AppApiModule extends _i7.AppApiModule {}

class _$DioProvider extends _i8.DioProvider {}
