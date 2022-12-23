import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/photo_item.dart';
import '../../services/photo_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PhotoService _photoService;

  HomeBloc(this._photoService) : super(const Initial()) {
    on<HomeEvent>((event, emit) {
      event.when(loadPhotos: _loadPhotos);
    });

    add(const HomeEvent.loadPhotos());
  }

  Future<void> _loadPhotos() async {
    await _photoService
        .getPhotos()
        .then((photos) => emit(HomeState.loadedPhotos(photos)))
        .catchError((error, _) => emit(HomeState.error(error.toString())));
  }
}
