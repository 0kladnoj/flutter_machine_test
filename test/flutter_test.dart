import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_machine_test/bloc/home/home_bloc.dart';
import 'package:flutter_machine_test/di/di.dart';
import 'package:flutter_machine_test/models/photo_item.dart';
import 'package:flutter_machine_test/services/photo_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart' as injectable;
import 'package:mockito/mockito.dart';

void main() {
  late final List<PhotoItem> items;

  setUpAll(() async {
    configureDependencies(
      const injectable.Environment(injectable.Environment.test),
    );

    locator.allowReassignment = true;
    final repository = locator<PhotoService>();
    items = await repository.getPhotos();
  });

  group('- Logic methods test', () {
    group('- ApiService class methods test', () {
      test('- Get Method Success test', () async {
        expect(items, isNotNull);
        expect(items.length, 5000);
      });
    });
    group('- BloC test', () {
      blocTest<MockHomeBloc, HomeState>(
        'emits [] when nothing is added',
        build: () => locator<MockHomeBloc>(),
        expect: () => <HomeState>[
          const Initial(),
          // LoadedPhotos(items),
        ],
      );
      blocTest<MockHomeBloc, HomeState>(
          'emits [HomeState] when MyEvent is added',
          build: () => locator<MockHomeBloc>(),
          act: (bloc) => bloc.add(const HomeEvent.loadPhotos()),
          wait: const Duration(seconds: 2),
          expect: () => [
                // const Loading(),
                // LoadedPhotos(items),
              ],
          verify: (_) {
            verify(() => locator<PhotoService>().getPhotos()).called(2);
          });
    });
  });
}
