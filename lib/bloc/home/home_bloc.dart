import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../base/bloc/base_bloc.dart';
import '../../models/photo_item.dart';
import '../../services/photo_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final PhotoService _photoService;

  HomeBloc(this._photoService) : super(const Initial()) {
    on<HomeEvent>((event, emit) {
      event.when(loadPhotos: _loadPhotos);
    });

    add(const HomeEvent.loadPhotos());
  }

  Future<void> _loadPhotos() async {
    await performSafeAction(() async {
      final photos = await _photoService.getPhotos();
      emit(HomeState.loadedPhotos(photos));
    });
  }

  @override
  void handleError(String massage) {
    emit(HomeState.error(massage));
  }
}
