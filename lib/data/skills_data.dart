import 'package:flutter/material.dart';
import '../models/experience_model.dart';

class SkillsData {
  static final List<SkillCategoryModel> categories = [
    SkillCategoryModel(
      name: 'Mobile Core & Platforms',
      icon: Icons.phone_android_rounded,
      accentColor: const Color(0xFF6366F1),
      skills: [
        'Flutter',
        'Dart',
        'Android (Native)',
        'iOS (Native)',
        'Cross-Platform Mobile',
        'Flutter Web',
      ],
    ),
    SkillCategoryModel(
      name: 'Architecture & State Management',
      icon: Icons.account_tree_outlined,
      accentColor: const Color(0xFF38BDF8),
      skills: [
        'Clean Architecture',
        'MVVM Pattern',
        'MVC Pattern',
        'Provider',
        'Riverpod',
        'GetX',
        'BLoC',
      ],
    ),
    SkillCategoryModel(
      name: 'APIs, Auth & Backend Workflows',
      icon: Icons.api_rounded,
      accentColor: const Color(0xFF10B981),
      skills: [
        'REST APIs',
        'GraphQL',
        'JSON Handling',
        'JWT Authentication',
        'Bearer Token Auth',
        'SMS/Email OTP Verification',
        'Falcon KWT SMS',
        'MSG91 & SMS Easy',
      ],
    ),
    SkillCategoryModel(
      name: 'Payment Gateways & Fintech',
      icon: Icons.payments_outlined,
      accentColor: const Color(0xFFF59E0B),
      skills: [
        'Razorpay',
        'QPay (Qatar)',
        'SkipCash',
        'MyFatoorah',
        'TAP Payments',
        'Apple Pay',
        'mada (Saudi Arabia)',
        'Visa & Mastercard',
        'SDK & WebView Redirection',
      ],
    ),
    SkillCategoryModel(
      name: 'Hardware, Device APIs & Maps',
      icon: Icons.map_outlined,
      accentColor: const Color(0xFFEC4899),
      skills: [
        'Google Maps SDK',
        'Location Selection & Geocoding',
        'Markers & Route Navigation',
        'Distance Calculations',
        'Biometric Auth (Fingerprint & Face ID)',
        'Camera & QR Generation/Scanner',
      ],
    ),
    SkillCategoryModel(
      name: 'Deployment, OTA & DevOps',
      icon: Icons.rocket_launch_outlined,
      accentColor: const Color(0xFF8B5CF6),
      skills: [
        'Shorebird Code Push',
        'OTA Hot Patch Workflows',
        'Google Play Console Release',
        'Apple App Store Connect',
        'Git, GitHub, GitLab',
        'CI/CD & AWS Basics',
      ],
    ),
    SkillCategoryModel(
      name: 'Cloud, Storage & Analytics',
      icon: Icons.cloud_outlined,
      accentColor: const Color(0xFF06B6D4),
      skills: [
        'Firebase',
        'Firebase Cloud Messaging (FCM)',
        'Firebase Analytics',
        'Local Storage',
        'Flutter Secure Storage',
        'PDF Generation & Viewing',
        'Multilingual / i18n Translations',
      ],
    ),
    SkillCategoryModel(
      name: 'Frontend & Web Development',
      icon: Icons.web_rounded,
      accentColor: const Color(0xFF3B82F6),
      skills: [
        'Angular',
        'Vue.js',
        'React.js',
        'JavaScript',
        'HTML5 & CSS3',
        'Responsive Web UI',
      ],
    ),
    SkillCategoryModel(
      name: 'Testing, QA & Modern AI Tools',
      icon: Icons.psychology_outlined,
      accentColor: const Color(0xFFA855F7),
      skills: [
        'Postman API Testing',
        'Flutter Unit & Widget Tests',
        'Integration & Regression Testing',
        'Manual QA (Android & iOS)',
        'Claude & Cursor AI',
        'Antigravity',
      ],
    ),
  ];
}

