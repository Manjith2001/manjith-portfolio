import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manjith_portfolio/core/constants/personal_info.dart';
import 'package:manjith_portfolio/data/projects_data.dart';
import 'package:manjith_portfolio/presentation/controllers/navigation_controller.dart';
import 'package:manjith_portfolio/presentation/sections/contact/contact_section.dart';
import 'package:manjith_portfolio/presentation/sections/projects/project_card.dart';
import 'package:manjith_portfolio/presentation/sections/projects/projects_section.dart';
import 'package:manjith_portfolio/presentation/widgets/tech_chip.dart';

void main() {
  group(
    'Functionality & Regression Tests: Category Filtering & Interaction',
    () {
      testWidgets('Tapping Video Demos filter updates visible projects', (
        tester,
      ) async {
        final nav = NavigationController();
        addTearDown(() => nav.dispose());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: ProjectsSection(navController: nav),
              ),
            ),
          ),
        );
        await tester.pump();

        // Find Video Demos chip and tap it
        final videoDemosChip = find.text('Video Demos');
        expect(videoDemosChip, findsOneWidget);

        await tester.tap(videoDemosChip);
        await tester.pump();

        // Enkage is a video demo project and should be visible
        expect(find.text('Enkage'), findsWidgets);
      });

      testWidgets('ProjectCard renders video indicators and payment badge', (
        tester,
      ) async {
        final enkage = ProjectsData.projects.firstWhere(
          (p) => p.id == 'enkage',
        );
        bool selected = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  width: 400,
                  child: ProjectCard(
                    project: enkage,
                    onSelect: () => selected = true,
                  ),
                ),
              ),
            ),
          ),
        );

        // Verify name, category, and Video Demo badge
        expect(find.text('Enkage'), findsOneWidget);
        expect(find.text('Video Demo'), findsOneWidget);
        expect(find.text('Client: Enkage Kuwait'), findsOneWidget);
        expect(find.text('Dynamic KWD Wallet'), findsOneWidget);

        // Tap card
        await tester.tap(find.text('Enkage'));
        expect(selected, isTrue);
      });
    },
  );

  group('Functionality Tests: Contact Form & Validation', () {
    testWidgets('Submitting empty form triggers validation error message', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 2200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SingleChildScrollView(child: ContactSection())),
        ),
      );
      await tester.pump();

      // Verify contact elements
      expect(find.text('Direct Inbox'), findsOneWidget);
      expect(find.text(PersonalInfo.email), findsWidgets);

      // Find send button and tap without filling
      final sendButton = find.text('Send Message to Email');
      expect(sendButton, findsOneWidget);

      await tester.tap(sendButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      // Error message should appear
      expect(
        find.text('Please provide your name or organization.'),
        findsOneWidget,
      );
    });

    testWidgets('TechChip responds to tap callbacks', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TechChip(label: 'Flutter', onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.text('Flutter'));
      expect(tapped, isTrue);
    });
  });

  group('Functionality Tests: NavigationController State Management', () {
    test('NavigationController opens and closes project details correctly', () {
      final nav = NavigationController();
      final project = ProjectsData.projects.first;

      expect(nav.selectedProject, isNull);

      nav.openProjectDetail(project);
      expect(nav.selectedProject, equals(project));
      expect(nav.selectedScreenshotIndex, equals(0));

      nav.nextScreenshot();
      if (project.screenshots.length > 1) {
        expect(nav.selectedScreenshotIndex, equals(1));
      }

      nav.closeProjectDetail();
      expect(nav.selectedProject, isNull);

      nav.dispose();
    });

    test('Lightbox modal state toggles properly', () {
      final nav = NavigationController();
      expect(nav.isLightboxOpen, isFalse);

      nav.openLightbox(2);
      expect(nav.isLightboxOpen, isTrue);
      expect(nav.selectedScreenshotIndex, equals(2));

      nav.closeLightbox();
      expect(nav.isLightboxOpen, isFalse);

      nav.dispose();
    });
  });
}
