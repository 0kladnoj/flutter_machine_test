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
    on<HomeEvent>((event, emit) async {
      emit(const Loading());
      final result = await event.when(loadPhotos: _loadPhotos);
      emit(result);
    });
  }

  @override
  HomeState handleError(String massage) {
    return HomeState.error(massage);
  }

  Future<HomeState> _loadPhotos() async {
    return await performSafeAction(() async {
      final photos = await _photoService.getPhotos();
      return HomeState.loadedPhotos(photos);
    });
  }
}
