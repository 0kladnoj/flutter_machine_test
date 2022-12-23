import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_machine_test/bloc/home/home_bloc.dart';
import 'package:flutter_machine_test/di/di.dart';
import 'package:flutter_machine_test/models/photo_item.dart';
import 'package:flutter_machine_test/services/photo_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  final dio = MockDio();
  late final List<PhotoItem> items;

  setUpAll(() async {
    configureDependencies();

    locator.allowReassignment = true;
    locator.registerSingleton<Dio>(dio);
    mockApiData(dio);
    final repository = locator<PhotoService>();
    items = await repository.getPhotos();
  });

  group('- Logic methods test', () {
    group('- ApiService class methods test', () {
      test('- Get Method Success test', () async {
        PhotoService repository = locator<PhotoService>();
        List<PhotoItem> items = await repository.getPhotos();
        expect(items, isNotNull);
        expect(items.length, 5000);
      });
    });
    group('- BloC test', () {
      blocTest<HomeBloc, HomeState>(
        'emits [] when nothing is added',
        build: () => locator<HomeBloc>(),
        expect: () => <HomeState>[
          const Loading(),
          LoadedPhotos(items),
        ],
      );
      blocTest<HomeBloc, HomeState>('emits [HomeState] when MyEvent is added',
          build: () => locator<HomeBloc>(),
          act: (bloc) => bloc.add(const HomeEvent.loadPhotos()),
          expect: () => <HomeState>[
                const Loading(),
                LoadedPhotos(items),
              ],
          verify: (_) {
            verify(() => locator<PhotoService>().getPhotos()).called(2);
          });
    });
  });
}

void mockApiData(Dio dio) {
  final file = File('test/json/photos.json').readAsStringSync();
  final map = json.decode(file);
  final response = Response(
      statusCode: 200,
      requestOptions: RequestOptions(path: 'gfh', baseUrl: "fgh"),
      data: map);
  when(dio.get("photos")).thenAnswer((_) async => response);
}
