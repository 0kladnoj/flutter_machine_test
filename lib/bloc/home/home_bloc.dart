import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../base/bloc/base_bloc.dart';
import '../../models/photo_item.dart';
import '../../services/photo_service.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final PhotoService _photoService;

  HomeBloc(this._photoService) : super(const Initial()) {
    on<HomeEvent>((event, emit) {
      event.when(loadPhotos: _loadPhotos);
    });
  }

  @override
  void handleError(String massage) {
    emit(HomeState.error(massage));
  }

  Future<void> _loadPhotos() async {
    await performSafeAction(() async {
      final photos = await _photoService.getPhotos();
      emit(HomeState.loadedPhotos(photos));
    });
  }
}

@injectable
class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {
  @override
  final PhotoService _photoService;
  
  MockHomeBloc(this._photoService) : super() {
    on<HomeEvent>((event, emit) {
      event.when(loadPhotos: _loadPhotos);
    });
    emit(const HomeState.initial());
  }

  @override
  void handleError(String massage) {
    emit(HomeState.error(massage));
  }

  @override
  Future<void> _loadPhotos() async {
    await performSafeAction(() async {
      final photos = await _photoService.getPhotos();
      emit(HomeState.loadedPhotos(photos));
    });
  }
}
