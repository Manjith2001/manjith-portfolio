import 'package:flutter_test/flutter_test.dart';
import 'package:manjith_portfolio/core/constants/personal_info.dart';
import 'package:manjith_portfolio/core/services/contact_service.dart';
import 'package:manjith_portfolio/data/clients_data.dart';
import 'package:manjith_portfolio/data/experience_data.dart';
import 'package:manjith_portfolio/data/projects_data.dart';

void main() {
  group('Unit Tests: ProjectsData & Assets', () {
    test('ProjectsData contains at least 16 production projects', () {
      expect(ProjectsData.projects.length, greaterThanOrEqualTo(16));
    });

    test('Video-enabled projects have valid videoAsset paths', () {
      final videoProjects = ProjectsData.projects
          .where((p) => p.hasVideo)
          .toList();
      // Enkage, Rentings, YalDiet, Healthy Diet, Champions Diet, Under Thirty, Nura, Steamed, Traffic Map
      expect(videoProjects.length, equals(9));

      for (final p in videoProjects) {
        expect(p.videoAsset, isNotNull);
        expect(p.videoAsset!, startsWith('assets/projects/'));
        expect(p.videoAsset!, endsWith('video.mp4'));
      }
    });

    test('All projects have non-empty required fields', () {
      for (final p in ProjectsData.projects) {
        expect(p.id.isNotEmpty, isTrue, reason: 'ID empty for ${p.name}');
        expect(p.name.isNotEmpty, isTrue);
        expect(p.category.isNotEmpty, isTrue);
        expect(p.shortDescription.isNotEmpty, isTrue);
        expect(p.fullDescription.isNotEmpty, isTrue);
        expect(p.role.isNotEmpty, isTrue);
        expect(p.technologies.isNotEmpty, isTrue);
        expect(p.features.isNotEmpty, isTrue);
        expect(p.platforms.isNotEmpty, isTrue);
      }
    });

    test('Categories contain Video Demos and standard categories', () {
      expect(ProjectsData.categories, contains('All'));
      expect(ProjectsData.categories, contains('Video Demos'));
      expect(ProjectsData.categories, contains('Featured'));
      expect(ProjectsData.categories, contains('Fintech & Loyalty'));
      expect(ProjectsData.categories, contains('Health & Nutrition'));
      expect(ProjectsData.categories, contains('Maps & Location'));
      expect(ProjectsData.categories, contains('SaaS & Property'));
    });

    test('Specific capabilities are properly flagged', () {
      final enkage = ProjectsData.projects.firstWhere((p) => p.id == 'enkage');
      expect(enkage.hasVideo, isTrue);
      expect(enkage.paymentGateways.isNotEmpty, isTrue);

      final trafficMap = ProjectsData.projects.firstWhere(
        (p) => p.id == 'traffic_map',
      );
      expect(trafficMap.hasVideo, isTrue);
      expect(trafficMap.hasMapIntegration, isTrue);

      final rentings = ProjectsData.projects.firstWhere(
        (p) => p.id == 'rentings',
      );
      expect(rentings.hasVideo, isTrue);
      expect(rentings.hasMapIntegration, isTrue);

      final yaldiet = ProjectsData.projects.firstWhere(
        (p) => p.id == 'yaldiet',
      );
      expect(yaldiet.hasVideo, isTrue);
      expect(yaldiet.hasShorebirdOta, isTrue);
    });
  });

  group('Unit Tests: Worked Clients & Experience Data', () {
    test('ClientsData contains distinguished worked clients', () {
      expect(ClientsData.clients.length, greaterThanOrEqualTo(8));
      for (final c in ClientsData.clients) {
        expect(c.name.isNotEmpty, isTrue);
        expect(c.domain.isNotEmpty, isTrue);
        expect(c.region.isNotEmpty, isTrue);
        expect(c.flag.isNotEmpty, isTrue);
        expect(c.scale.isNotEmpty, isTrue);
        expect(c.technologies.isNotEmpty, isTrue);
      }
    });

    test('ExperienceData has Cocopalms as current employer', () {
      expect(ExperienceData.experiences.isNotEmpty, isTrue);
      final current = ExperienceData.experiences.firstWhere((e) => e.isCurrent);
      expect(current.company, contains('Cocopalms'));
      expect(current.responsibilities.length, greaterThanOrEqualTo(10));
    });

    test('PersonalInfo has correct developer email and name', () {
      expect(PersonalInfo.name, 'Manjith Hemachandran');
      expect(PersonalInfo.email, 'manjithhemachandran333@gmail.com');
      expect(PersonalInfo.yearsOfExperience, '2.5+');
      expect(PersonalInfo.productionAppsCount, '17+');
    });
  });

  group('Unit Tests: ContactService & Form Validation', () {
    test('Email regex validation correctly validates addresses', () {
      expect(ContactService.isValidEmail('manjith@gmail.com'), isTrue);
      expect(ContactService.isValidEmail('alex.developer@company.org'), isTrue);
      expect(ContactService.isValidEmail('invalid-email'), isFalse);
      expect(ContactService.isValidEmail('user@'), isFalse);
      expect(ContactService.isValidEmail('@domain.com'), isFalse);
      expect(ContactService.isValidEmail(''), isFalse);
    });

    test('ContactSubmission generates correct JSON format', () {
      const sub = ContactSubmission(
        name: 'John Doe',
        email: 'john@example.com',
        category: 'Commercial Mobile Development',
        message: 'Looking for a senior Flutter developer.',
      );
      final json = sub.toJson();
      expect(json['name'], 'John Doe');
      expect(json['email'], 'john@example.com');
      expect(json['category'], 'Commercial Mobile Development');
      expect(json['message'], 'Looking for a senior Flutter developer.');
      expect(json['_replyto'], 'john@example.com');
    });

    test('ContactService rejects submission with empty name', () async {
      const sub = ContactSubmission(
        name: '',
        email: 'test@example.com',
        category: 'General',
        message: 'Hello world',
      );
      final res = await ContactService.submitInquiry(sub);
      expect(res.isSuccess, isFalse);
      expect(res.message, contains('name'));
    });

    test('ContactService rejects submission with invalid email', () async {
      const sub = ContactSubmission(
        name: 'John',
        email: 'invalid-email',
        category: 'General',
        message: 'Hello world',
      );
      final res = await ContactService.submitInquiry(sub);
      expect(res.isSuccess, isFalse);
      expect(res.message, contains('valid email'));
    });

    test('ContactService rejects submission with short message', () async {
      const sub = ContactSubmission(
        name: 'John',
        email: 'john@example.com',
        category: 'General',
        message: 'hi',
      );
      final res = await ContactService.submitInquiry(sub);
      expect(res.isSuccess, isFalse);
      expect(res.message, contains('at least 5 characters'));
    });
  });
}
