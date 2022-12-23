part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = Initial;
  const factory HomeState.loading() = Loading;
  const factory HomeState.loadedPhotos(List<PhotoItem> photos) = LoadedPhotos;
  const factory HomeState.error(String error) = Error;
}
