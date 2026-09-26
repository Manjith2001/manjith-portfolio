import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manjith_portfolio/core/constants/personal_info.dart';
import 'package:manjith_portfolio/main.dart';

void main() {
  testWidgets('Portfolio loads and displays on Desktop viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const ManjithPortfolioApp());
    await tester.pump();

    // Verify name and title appear in Hero
    expect(find.text(PersonalInfo.name), findsWidgets);
    expect(find.text(PersonalInfo.title), findsWidgets);

    // Verify Worked Clients & Ecosystems section header is present
    expect(find.text('Worked Clients & Commercial Brands'), findsOneWidget);

    // Verify Video Demos category pill is present
    expect(find.text('Video Demos'), findsOneWidget);
  });

  testWidgets('Portfolio loads and displays on Tablet viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(820, 1180);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const ManjithPortfolioApp());
    await tester.pump();

    // Verify name appears
    expect(find.text(PersonalInfo.name), findsWidgets);
    // Menu icon is visible on tablet/mobile
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
  });

  testWidgets('Portfolio loads and displays on Mobile viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const ManjithPortfolioApp());
    await tester.pump();

    // Verify name appears
    expect(find.text(PersonalInfo.name), findsWidgets);
    // Mobile menu icon is visible
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);

    // Open mobile menu
    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify mobile drawer options
    expect(find.text('Download Resume (PDF)'), findsOneWidget);
    expect(find.text('Worked Clients & Brands'), findsOneWidget);
  });
}
