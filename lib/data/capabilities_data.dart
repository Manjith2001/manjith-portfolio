import 'package:flutter/material.dart';
import '../models/experience_model.dart';

class CapabilitiesData {
  static final List<CapabilityModel> capabilities = [
    CapabilityModel(
      title: 'Scalable Clean Architecture & State',
      subtitle: 'Robust Separation of Concerns',
      icon: Icons.architecture_rounded,
      description:
          'Designing enterprise-ready Flutter applications using Clean Architecture principles, '
          'MVVM/MVC patterns, and battle-tested state management (Riverpod, Provider, GetX, BLoC) '
          'to ensure high maintainability, unit-testability, and zero spaghetti code.',
      tags: ['Clean Architecture', 'Riverpod', 'Provider', 'GetX', 'BLoC', 'Unit Testing'],
      accentColor: const Color(0xFF6366F1),
    ),
    CapabilityModel(
      title: 'End-to-End Payment Gateways',
      subtitle: 'Multi-Country Commercial Integrations',
      icon: Icons.credit_card_rounded,
      description:
          'Deep production experience integrating 9+ international and Middle East payment gateways '
          '(Razorpay, QPay, SkipCash, MyFatoorah, TAP, Apple Pay, mada, Visa, Mastercard) via direct SDKs, '
          'custom WebView redirections, webhooks, and backend verification APIs.',
      tags: ['Razorpay', 'QPay', 'mada', 'Apple Pay', 'TAP', 'MyFatoorah', 'SkipCash'],
      accentColor: const Color(0xFF10B981),
    ),
    CapabilityModel(
      title: 'Google Maps, Geolocation & Routing',
      subtitle: 'Location-Driven Systems',
      icon: Icons.near_me_rounded,
      description:
          'Engineering location-aware experiences: interactive map canvas, custom marker clusters, '
          'address pickers, geocoding, boundary polygons, real-time traffic overlays, and distance calculation formulas.',
      tags: ['Google Maps SDK', 'Geocoding', 'Live Traffic', 'Route Calculation', 'Address Picker'],
      accentColor: const Color(0xFF38BDF8),
    ),
    CapabilityModel(
      title: 'Production Releases & Shorebird OTA',
      subtitle: 'Zero-Downtime Maintenance',
      icon: Icons.bolt_rounded,
      description:
          'Personally orchestrated Shorebird production release and instant over-the-air (OTA) '
          'patch workflows across 17 applications on Google Play Store and Apple App Store, '
          'bypassing traditional multi-day store approval queues for critical bug fixes.',
      tags: ['Shorebird OTA', 'Play Store Releases', 'App Store Connect', 'Instant Patches', 'CI/CD'],
      accentColor: const Color(0xFFF59E0B),
    ),
    CapabilityModel(
      title: 'Business & Mathematical Calculation Engines',
      subtitle: 'Domain Logic Beyond UI',
      icon: Icons.calculate_outlined,
      description:
          'Implementing complex mathematical engines for calorie budgets, BMI index, macro nutrient splits '
          '(protein, carbs, fats), age/height/weight adjustments, flexible meal calendars, and dynamic subscription pricing.',
      tags: ['Calorie & BMI Logic', 'Macro Algorithms', 'Subscription Engines', 'Dynamic Pricing'],
      accentColor: const Color(0xFF8B5CF6),
    ),
    CapabilityModel(
      title: 'Hardware, Biometrics & Security',
      subtitle: 'Native Device Capabilities',
      icon: Icons.fingerprint_rounded,
      description:
          'Implementing native biometric authentication (Fingerprint and Apple Face ID), camera-driven '
          'QR code scanning/generation, JWT Bearer token lifecycle, and secure keychain/keystore storage.',
      tags: ['Biometric Auth', 'Face ID', 'QR Scanner', 'JWT Security', 'Secure Storage'],
      accentColor: const Color(0xFFEC4899),
    ),
  ];
}

