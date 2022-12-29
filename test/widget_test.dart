// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_machine_test/di/di.dart';
import 'package:flutter_machine_test/machine_test_app.dart';
import 'package:flutter_machine_test/services/photo_service.dart';
import 'package:flutter_machine_test/utils/app_strings.dart';
import 'package:flutter_machine_test/utils/app_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart' as injectable;

void main() {
  setUpAll(() async {
    configureDependencies(
      const injectable.Environment(injectable.Environment.test),
    );

    locator.allowReassignment = true;
  });

  group('- Home Screen test', () {
    testWidgets('- Load data test', (WidgetTester tester) async {
      await tester.pumpWidget(const MachineTestApp());
      expect(find.text(AppStrings.photos), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('- List scroll test', (WidgetTester tester) async {
      await tester.pumpWidget(const MachineTestApp());
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byKey(Key(AppUtils.cardKey(1))), findsOneWidget);

      await tester.dragUntilVisible(
        find.byKey(Key(AppUtils.cardKey(100))),
        find.byType(ListView),
        const Offset(0, -200),
        duration: const Duration(seconds: 2),
      );
      expect(find.byKey(Key(AppUtils.cardKey(1))), findsNothing);
    });

    testWidgets('- Show detail screen test', (WidgetTester tester) async {
      await tester.pumpWidget(const MachineTestApp());
      await tester.pump();
      await tester.dragUntilVisible(
        find.byKey(Key(AppUtils.cardKey(100))),
        find.byType(ListView),
        const Offset(0, -200),
        duration: const Duration(seconds: 2),
      );
      final repository = locator<PhotoService>();
      final items = await repository.getPhotos();
      final item = items.firstWhere((e) => e.id == 100);
      final selectedItem = find.byKey(Key(AppUtils.cardKey(100)));
      await tester.tap(selectedItem);
      await tester.pump();
      expect(
        find.text(AppUtils.photoId(item.id), skipOffstage: false),
        findsOneWidget,
      );
      expect(find.text(item.title), findsOneWidget);
      expect(
        find.text(AppUtils.photoAlbum(item.albumId), skipOffstage: false),
        findsOneWidget,
      );
    });
  });
}
