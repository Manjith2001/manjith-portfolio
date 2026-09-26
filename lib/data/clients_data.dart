import 'package:flutter/material.dart';

class ClientModel {
  final String id;
  final String name;
  final String domain;
  final String region;
  final String flag;
  final String highlight;
  final List<String> technologies;
  final Color accentColor;
  final IconData icon;
  final String scale;

  const ClientModel({
    required this.id,
    required this.name,
    required this.domain,
    required this.region,
    required this.flag,
    required this.highlight,
    required this.technologies,
    required this.accentColor,
    required this.icon,
    required this.scale,
  });
}

class ClientsData {
  static const List<ClientModel> clients = [
    ClientModel(
      id: 'enkage',
      name: 'Enkage Kuwait',
      domain: 'FinTech & Merchant Loyalty',
      region: 'Kuwait',
      flag: '🇰🇼',
      scale: 'Play Store & App Store',
      highlight: 'Dynamic multi-currency digital wallet, merchant deal discovery, tap-to-scan QR redemption, and instant flash notifications.',
      technologies: ['KWD Wallet', 'QR Scanner', 'JWT Auth', 'Firebase FCM'],
      accentColor: Color(0xFF38BDF8),
      icon: Icons.account_balance_wallet_rounded,
    ),
    ClientModel(
      id: 'rentings',
      name: 'Rentings PropTech',
      domain: 'Real Estate SaaS & Tenancy',
      region: 'GCC & India',
      flag: '🌍 🇮🇳',
      scale: 'Production SaaS',
      highlight: 'End-to-end rental tenancy automation, maintenance ticket tracking, PDF contract generation, and Google Maps property tagging.',
      technologies: [
        'Google Maps SDK',
        'PDF Generation',
        'REST APIs',
        'Ticketing Engine',
      ],
      accentColor: Color(0xFF0284C7),
      icon: Icons.apartment_rounded,
    ),
    ClientModel(
      id: 'under_thirty',
      name: 'Under Thirty Diet',
      domain: 'Health & Nutrition Subscriptions',
      region: 'Qatar',
      flag: '🇶🇦',
      scale: 'Commercial Subscription',
      highlight: 'Nutritional meal subscription platform featuring custom macro algorithms, QPay regional checkout, and WhatsApp consultation.',
      technologies: [
        'QPay Gateway',
        'Macro Logic',
        'In-App Wallet',
        'WhatsApp API',
      ],
      accentColor: Color(0xFF0D9488),
      icon: Icons.restaurant_menu_rounded,
    ),
    ClientModel(
      id: 'approved_life',
      name: 'Approved Life KSA',
      domain: 'Certified Health & Nutrition',
      region: 'Saudi Arabia',
      flag: '🇸🇦',
      scale: 'Play Store & App Store',
      highlight: 'Certified Saudi health platform with integrated mada debit cards, Apple Pay, SMS OTP verification, and Google Maps address selection.',
      technologies: ['mada Debit', 'Apple Pay', 'Falcon SMS', 'Google Maps'],
      accentColor: Color(0xFF059669),
      icon: Icons.verified_user_rounded,
    ),
    ClientModel(
      id: 'yaldiet',
      name: 'YalDiet Gulf',
      domain: 'Bilingual Diet Platform',
      region: 'GCC Region',
      flag: '🌍',
      scale: 'Bilingual RTL/LTR',
      highlight: 'Arabic & English health meal subscription engine deployed with Shorebird zero-downtime OTA hot patches and TAP multi-gateway payments.',
      technologies: [
        'Shorebird OTA',
        'TAP Gateway',
        'RTL Localization',
        'Apple Pay',
      ],
      accentColor: Color(0xFF1E3A8A),
      icon: Icons.translate_rounded,
    ),
    ClientModel(
      id: 'champions_diet',
      name: 'The Champions Diet',
      domain: 'Athletic Performance Nutrition',
      region: 'GCC Region',
      flag: '🌍',
      scale: 'Play Store & App Store',
      highlight: 'High-protein meal subscriptions for athletes with biometric login (Face ID/Fingerprint), macro calculators, and card checkout.',
      technologies: [
        'Biometrics',
        'Macro Calculator',
        'Apple Pay',
        'Visa/Mastercard',
      ],
      accentColor: Color(0xFFE11D48),
      icon: Icons.fitness_center_rounded,
    ),
    ClientModel(
      id: 'traffic_mobility',
      name: 'Smart Mobility Transit',
      domain: 'Real-Time Maps & Navigation',
      region: 'Singapore & Malaysia',
      flag: '🇸🇬 🇲🇾',
      scale: 'Active Live Tracking',
      highlight: 'Google Maps SDK traffic layer monitor with cross-border checkpoint status, route calculation, and real-time GPS overlays.',
      technologies: [
        'Google Maps SDK',
        'Live Traffic API',
        'Geolocator',
        'Routes API',
      ],
      accentColor: Color(0xFFEF4444),
      icon: Icons.map_rounded,
    ),
    ClientModel(
      id: 'steamed_health',
      name: 'Steamed Health',
      domain: 'Culinary Nutrition Platform',
      region: 'GCC Region',
      flag: '🌍',
      scale: 'Production Release',
      highlight: 'Healthy meal plan subscription service with BMI & macro calculation engine, dark culinary aesthetics, and card checkout.',
      technologies: ['Flutter', 'BMI Engine', 'Payment Gateway', 'Apple Pay'],
      accentColor: Color(0xFF10B981),
      icon: Icons.restaurant_rounded,
    ),
    ClientModel(
      id: 'nura_diet',
      name: 'Nura Diet',
      domain: 'Digital Meal Subscriptions',
      region: 'Kuwait & GCC',
      flag: '🇰🇼 🌍',
      scale: 'Live Store App',
      highlight: 'Full-featured nutritional ordering platform with in-app wallet credits, KNET payment gateway, and WhatsApp customer service integration.',
      technologies: [
        'KNET Gateway',
        'Credit Wallet',
        'WhatsApp API',
        'REST APIs',
      ],
      accentColor: Color(0xFFEC4899),
      icon: Icons.local_dining_rounded,
    ),
  ];
}
