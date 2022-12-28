import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_machine_test/bloc/home/home_bloc.dart';
import 'package:flutter_machine_test/di/di.dart';
import 'package:flutter_machine_test/services/photo_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart' as injectable;

void main() {
  setUpAll(() async {
    configureDependencies(
      const injectable.Environment(injectable.Environment.test),
    );
  });

  group('- Logic methods test', () {
    group('- ApiService class methods test', () {
      test('- Get Method Success test', () async {
        final repository = locator<PhotoService>();
        final items = await repository.getPhotos();

        expect(items, isNotNull);
        expect(items.length, 5000);
      });
    });
  });

  group('- BLoC Tests', () {
    blocTest<HomeBloc, HomeState>(
      'emits [] when nothing is added',
      build: () => locator<HomeBloc>(),
      expect: () => <HomeState>[],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeState] when MyEvent is added',
      build: () => locator<HomeBloc>(),
      act: (bloc) => bloc.add(const HomeEvent.loadPhotos()),
      wait: const Duration(seconds: 2),
      setUp: () {},
      expect: () => [
        const Loading(),
        isA<LoadedPhotos>(),
      ],
    );
  });
}
