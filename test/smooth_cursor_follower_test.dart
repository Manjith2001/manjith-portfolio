import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manjith_portfolio/presentation/widgets/smooth_cursor_follower.dart';

void main() {
  group('SmoothCursorFollower Tests', () {
    testWidgets('Renders child content and allows interaction without interference', (
      WidgetTester tester,
    ) async {
      bool buttonTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothCursorFollower(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    buttonTapped = true;
                  },
                  child: const Text('Test Interactive Button'),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify button and text exist
      expect(find.text('Test Interactive Button'), findsOneWidget);

      // Verify tap works completely unimpeded (zero breakage of child functionality)
      await tester.tap(find.text('Test Interactive Button'));
      await tester.pump();

      expect(buttonTapped, isTrue);
    });

    testWidgets('Provides SmoothCursorProvider with cursorNotifier to descendants', (
      WidgetTester tester,
    ) async {
      ValueNotifier<Offset?>? capturedNotifier;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothCursorFollower(
              child: Builder(
                builder: (context) {
                  capturedNotifier = SmoothCursorProvider.maybeOf(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );

      expect(capturedNotifier, isNotNull);
      expect(capturedNotifier!.value, isNull);
    });

    testWidgets('Pointer move and touch events work without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothCursorFollower(
              child: Container(
                width: 500,
                height: 500,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      );

      // Test mouse movement
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: const Offset(100, 100));
      await tester.pump();

      await gesture.moveTo(const Offset(200, 200));
      await tester.pump();

      await gesture.down(const Offset(200, 200));
      await tester.pump();

      await gesture.up();
      await tester.pump();

      await gesture.removePointer();
      await tester.pump();

      // Test touch gesture
      final touchGesture = await tester.createGesture(kind: PointerDeviceKind.touch);
      await touchGesture.addPointer(location: const Offset(50, 50));
      await touchGesture.down(const Offset(50, 50));
      await tester.pump();

      await touchGesture.moveTo(const Offset(150, 150));
      await tester.pump();

      await touchGesture.up();
      await tester.pump();

      await touchGesture.removePointer();
      await tester.pump();
    });
  });
}