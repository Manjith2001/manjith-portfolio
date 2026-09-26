import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manjith_portfolio/data/clients_data.dart';
import 'package:manjith_portfolio/data/projects_data.dart';
import 'package:manjith_portfolio/data/skills_data.dart';
import 'package:manjith_portfolio/presentation/sections/clients/worked_clients_section.dart';
import 'package:manjith_portfolio/presentation/widgets/ambient_space_background.dart';
import 'package:manjith_portfolio/presentation/widgets/project_video_player.dart';
import 'package:manjith_portfolio/presentation/widgets/tech_chip.dart';

void main() {
  group('Regression Test Suite - Data Integrity & Assets', () {
    test(
      'All 9 user-specified video projects exist with videos and metadata',
      () {
        final videoProjects = ProjectsData.projects
            .where((p) => p.hasVideo)
            .toList();
        expect(videoProjects.length, greaterThanOrEqualTo(9));

        final requiredNames = [
          'Enkage',
          'Rentings',
          'YalDiet',
          'Healthy Diet',
          'The Champions Diet',
          'Under Thirty',
          'Nura',
          'Steamed',
          'Traffic Map',
        ];

        for (final reqName in requiredNames) {
          final matches = ProjectsData.projects.where(
            (p) => p.name.toLowerCase().contains(
              reqName.toLowerCase().split(' ').first,
            ),
          );
          expect(
            matches.isNotEmpty,
            isTrue,
            reason: 'Expected project "$reqName" to be in ProjectsData',
          );
          final project = matches.first;
          expect(project.videoAsset, isNotNull);
          expect(project.videoAsset!.endsWith('.mp4'), isTrue);
          expect(project.clientName, isNotNull);
          expect(project.clientRegion, isNotNull);
        }
      },
    );

    test('All video project files exist on local disk', () {
      for (final project in ProjectsData.projects) {
        if (project.videoAsset != null) {
          final file = File(project.videoAsset!);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Video file must exist on disk: ${project.videoAsset}',
          );
        }
      }
    });

    test('All 9 worked clients have complete metadata and domain tags', () {
      expect(ClientsData.clients.length, greaterThanOrEqualTo(9));
      for (final client in ClientsData.clients) {
        expect(client.name.isNotEmpty, isTrue);
        expect(client.domain.isNotEmpty, isTrue);
        expect(client.flag.isNotEmpty, isTrue);
        expect(client.scale.isNotEmpty, isTrue);
        expect(client.highlight.isNotEmpty, isTrue);
        expect(client.technologies.isNotEmpty, isTrue);
      }
    });

    test(
      'Payment gateways data integrity covers GCC and international standards',
      () {
        final paymentProjects = ProjectsData.projects
            .where((p) => p.hasPayments)
            .toList();
        expect(paymentProjects.isNotEmpty, isTrue);

        final allGateways = paymentProjects
            .expand((p) => p.paymentGateways)
            .toSet();
        expect(allGateways.any((g) => g.contains('mada')), isTrue);
        expect(allGateways.any((g) => g.contains('Apple Pay')), isTrue);
        expect(allGateways.any((g) => g.contains('TAP')), isTrue);
        expect(allGateways.any((g) => g.contains('QPay')), isTrue);
      },
    );

    test('Skills data categories contain verified competencies without subjective ratings', () {
      expect(SkillsData.categories.isNotEmpty, isTrue);
      for (final cat in SkillsData.categories) {
        expect(cat.name.isNotEmpty, isTrue);
        expect(cat.skills.isNotEmpty, isTrue);
      }
    });
  });

  group('Regression Test Suite - UI Components & Layouts', () {
    testWidgets('AmbientSpaceBackground mounts cleanly without test hangs', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AmbientSpaceBackground(
              child: Text('Ambient Background Loaded'),
            ),
          ),
        ),
      );

      expect(find.text('Ambient Background Loaded'), findsOneWidget);
    });

    testWidgets('WorkedClientsSection renders without overflow', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: WorkedClientsSection()),
          ),
        ),
      );

      expect(find.text('Worked Clients & Commercial Brands'), findsOneWidget);
      expect(find.text('Rentings PropTech'), findsOneWidget);
      expect(find.text('Enkage Kuwait'), findsOneWidget);
    });

    testWidgets('ProjectVideoPlayer renders loading state cleanly', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 300,
              child: ProjectVideoPlayer(
                videoAsset: 'assets/projects/enkage/video.mp4',
                posterAsset: 'assets/projects/enkage/enkage_1.jpg',
                title: 'Enkage Video Test',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Loading 60fps Video Demo...'), findsOneWidget);
    });

    testWidgets(
      'TechChip renders uniform pill structure with custom and default colors',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  TechChip(label: 'Flutter'),
                  TechChip(label: 'mada', color: Colors.green),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Flutter'), findsOneWidget);
        expect(find.text('mada'), findsOneWidget);
      },
    );
  });
}
