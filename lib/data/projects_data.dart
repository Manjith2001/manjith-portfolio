import 'package:flutter/material.dart';

import '../models/project_model.dart';

class ProjectsData {
  static const List<String> categories = [
    'All',
    'Video Demos',
    'Featured',
    'Fintech & Loyalty',
    'Health & Nutrition',
    'Maps & Location',
    'SaaS & Property',
  ];

  static final List<ProjectModel> projects = [
    // 1. Enkage (Video Demo Available)
    ProjectModel(
      id: 'enkage',
      name: 'Enkage',
      category: 'Fintech & Loyalty',
      clientName: 'Enkage Kuwait',
      clientRegion: 'Kuwait 🇰🇼',
      videoAsset: 'assets/projects/enkage/video.mp4',
      shortDescription: 'Comprehensive digital wallet, member promotions, merchant discount discovery, and instant QR coupon redemption platform.',
      fullDescription:
          'Enkage is an elite loyalty and merchant offers application developed in Flutter. '
          'Features a dynamic multi-currency wallet (KWD), real-time coupon status auto-updates, '
          'merchant discovery filters (promotions, shopping, dining, BOGO deals), and an instant QR scanning redemption workflow. '
          'Integrated with robust authentication, JWT security tokens, and Firebase Cloud Messaging for targeted promotional push notifications.',
      role: 'Mobile Developer & Frontend Engineer',
      technologies: [
        'Flutter',
        'Dart',
        'REST APIs',
        'JWT Auth',
        'Firebase FCM',
        'QR Scanning',
        'Clean Architecture',
      ],
      features: [
        'Total Wallet Value tracking with dynamic status auto-updates',
        'Interactive merchant offer discovery with category & filter chips',
        'Tap to Scan instant QR code redemption for partner stores',
        'Coupon voucher management with active/redeemed/expired state tracking',
        'Push notifications for flash member offers and seasonal discounts',
        'Direct WhatsApp merchant inquiry and member support integration',
      ],
      integrations: [
        'Camera & QR Scanner',
        'Firebase Cloud Messaging',
        'Secure Storage',
        'REST APIs',
      ],
      paymentGateways: ['Dynamic KWD Wallet', 'JWT Auth', 'QR Scan Checkout'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.enkage.app&pcampaignid=web_share',
      appStoreUrl: 'https://apps.apple.com/in/app/enkage/id6761419856',
      screenshots: [
        'assets/projects/enkage/enkage_1.jpg',
        'assets/projects/enkage/enkage_2.jpg',
        'assets/projects/enkage/enkage_3.jpg',
        'assets/projects/enkage/enkage_4.jpg',
      ],
      isFeatured: true,
      accentColor: const Color(0xFF6366F1),
    ),

    // 2. Rentings (Video Demo Available)
    ProjectModel(
      id: 'rentings',
      name: 'Rentings',
      category: 'SaaS & Property',
      clientName: 'Rentings PropTech',
      clientRegion: 'GCC / India 🌍',
      videoAsset: 'assets/projects/rentings/video.mp4',
      hasMapIntegration: true,
      shortDescription: 'End-to-end property rental management system managing digital tenancy contracts, maintenance ticketing, and real-time status alerts.',
      fullDescription:
          'Rentings streamlines property and tenancy operations. Tenants and property managers track lease contracts, '
          'submit and monitor maintenance service requests with timestamped status updates (Fixed, In Progress, Pending), '
          'and receive real-time push alerts. Built with modular UI widgets, Google Maps property location tagging, secure document viewing, and seamless backend API workflows.',
      role: 'Flutter Mobile Developer',
      technologies: [
        'Flutter',
        'Dart',
        'REST APIs',
        'Firebase FCM',
        'PDF Viewer',
        'Google Maps SDK',
        'Clean Architecture',
      ],
      features: [
        'Contract lifecycle tracking and digital lease agreement management',
        'Maintenance request ticketing with live status badges (Fixed, In Progress, Created)',
        'Timeline-driven activity logs and automated tenant notifications',
        'Document downloading and PDF contract review',
        'Interactive property location pinning on Google Maps',
        'Profile management and multi-unit switching',
      ],
      integrations: [
        'PDF Generation & Viewer',
        'FCM Push Notifications',
        'Google Maps SDK',
        'Secure Storage',
        'REST Backend',
      ],
      paymentGateways: ['Visa', 'Mastercard', 'Digital Invoicing Engine'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=cocopalms.rentings.app&pcampaignid=web_share',
      screenshots: [
        'assets/projects/rentings/rentings_1.jpg',
        'assets/projects/rentings/rentings_2.jpg',
        'assets/projects/rentings/rentings_3.jpg',
      ],
      isFeatured: true,
      accentColor: const Color(0xFF0284C7),
    ),

    // 3. Under Thirty Diet (Video Demo Available)
    ProjectModel(
      id: 'under_thirty',
      name: 'Under Thirty Diet',
      category: 'Health & Nutrition',
      clientName: 'Under Thirty Diet Qatar',
      clientRegion: 'Qatar 🇶🇦',
      videoAsset: 'assets/projects/under_thirty/video.mp4',
      shortDescription: 'Personalized meal plan subscription app featuring dynamic nutritional logic, custom calorie goals, in-app wallet, and nutritionist consultation.',
      fullDescription:
          'Under Thirty Diet is a comprehensive wellness subscription mobile app operating in Qatar (Q.R currency). '
          'Features dynamic meal planning, custom dietary packages (e.g. 26-day flash offers), integrated nutritionist chat via WhatsApp, '
          'in-app wallet credits, and referral reward bonuses. Implements mathematical calorie and macro algorithms and QPay regional payment integration.',
      role: 'Mobile Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Payment Gateways',
        'QPay',
        'REST APIs',
        'Clean Architecture',
        'Nutrition Logic',
      ],
      features: [
        'Custom meal plan builder with nutritionist-curated meal packages',
        'Flash offer promotions with discount code verification',
        'In-app digital wallet and subscription credit balance',
        'Direct nutritionist consultation booking via WhatsApp',
        'Friend referral reward system (Give & Get)',
        'Multi-week calendar meal scheduling',
      ],
      integrations: [
        'QPay / Regional Payment Gateway',
        'WhatsApp Direct',
        'Firebase Analytics',
        'REST APIs',
      ],
      paymentGateways: [
        'QPay Regional Gateway',
        'In-App Wallet Credits',
        'Apple Pay',
      ],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cocopalms.UnderThirtyDiet&pcampaignid=web_share',
      screenshots: [
        'assets/projects/under_thirty/under_thirty_1.jpg',
        'assets/projects/under_thirty/under_thirty_2.jpg',
        'assets/projects/under_thirty/under_thirty_3.jpg',
        'assets/projects/under_thirty/under_thirty_4.jpg',
      ],
      isFeatured: true,
      accentColor: const Color(0xFF0D9488),
    ),

    // 4. The Champions Diet (Video Demo Available)
    ProjectModel(
      id: 'champions_diet',
      name: 'The Champions Diet',
      category: 'Health & Nutrition',
      clientName: 'The Champions Athletic Diet',
      clientRegion: 'GCC 🌍',
      videoAsset: 'assets/projects/champions_diet/video.mp4',
      shortDescription: 'Athletic nutrition and performance-driven meal subscription app released on Google Play and Apple App Store.',
      fullDescription:
          'Designed for athletes and fitness enthusiasts requiring high-protein and calculated calorie intakes. '
          'Features macro calculators, subscription delivery scheduling, biometric login (Face ID & Fingerprint), and multi-gateway payments.',
      role: 'Flutter Mobile Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Biometrics',
        'Macro Calculations',
        'Payment Gateways',
        'Clean Architecture',
      ],
      features: [
        'Athletic meal plans with customized protein & carb targets',
        'Biometric authentication (Fingerprint and Face ID)',
        'Payment integration via Apple Pay, Visa, and Mastercard',
        'Interactive calendar for daily high-protein dish selections',
      ],
      integrations: [
        'Biometric Auth',
        'Payment Gateways',
        'FCM Push Notifications',
      ],
      paymentGateways: ['Apple Pay', 'Visa', 'Mastercard'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cocopalms.ChampionDiet&pcampaignid=web_share',
      appStoreUrl:
          'https://apps.apple.com/in/app/the-champion-diet/id6768715767',
      screenshots: [],
      isFeatured: true,
      accentColor: const Color(0xFFE11D48),
    ),

    // 5. Healthy Diet (Video Demo Available)
    ProjectModel(
      id: 'healthy_diet',
      name: 'Healthy Diet',
      category: 'Health & Nutrition',
      clientName: 'Healthy Diet Co.',
      clientRegion: 'Kuwait & UAE 🇰🇼 🇦🇪',
      videoAsset: 'assets/projects/healthy_diet/video.mp4',
      hasMapIntegration: true,
      shortDescription: 'Clean, minimalist diet and nutrition platform enabling users to build lasting healthy habits with curated daily meal subscriptions.',
      fullDescription:
          'Healthy Diet helps users discover, customize, and subscribe to wholesome meal plans. '
          'Features Arabic & English support, Clean Architecture with state management, interactive Google Maps location picker, and streamlined checkout workflows.',
      role: 'Flutter Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Clean Architecture',
        'Google Maps SDK',
        'State Management',
        'REST APIs',
      ],
      features: [
        'Personalized nutrition plan subscription catalog',
        'Bilingual Arabic/English interface with instant toggle',
        'Cart, checkout, and address location selection via Google Maps',
        'Automated meal deliveries scheduling and notifications',
      ],
      integrations: [
        'Payment Gateway',
        'Google Maps Location Picker',
        'Firebase Cloud Messaging',
      ],
      paymentGateways: ['KNET Regional Gateway', 'Visa', 'Mastercard'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cocopalms.healthydiet&pcampaignid=web_share',
      screenshots: [
        'assets/projects/healthy_diet/healthy_diet_1.jpg',
        'assets/projects/healthy_diet/healthy_diet_2.jpg',
        'assets/projects/healthy_diet/healthy_diet_3.jpg',
      ],
      isFeatured: true,
      accentColor: const Color(0xFF2E7D32),
    ),

    // 6. YalDiet (Video Demo Available)
    ProjectModel(
      id: 'yaldiet',
      name: 'YalDiet',
      category: 'Health & Nutrition',
      clientName: 'YalDiet Gulf',
      clientRegion: 'GCC 🌍',
      videoAsset: 'assets/projects/yaldiet/video.mp4',
      hasShorebirdOta: true,
      shortDescription: 'Bilingual (Arabic & English) health subscription platform providing streamlined daily meal planning ("Meals Made Simple").',
      fullDescription:
          'YalDiet is a bilingual diet subscription app operating across the Gulf region. '
          'Features full RTL/LTR internationalization, monthly meal plan management, calendar menu selection, TAP payment gateway integration, and Shorebird OTA releases.',
      role: 'Mobile Developer & Frontend',
      technologies: [
        'Flutter',
        'Dart',
        'Multilingual i18n',
        'REST APIs',
        'Payment Gateways',
        'Shorebird OTA',
      ],
      features: [
        'Seamless Arabic and English language switching (RTL / LTR)',
        'Custom meal plan registration and dietary goal definition',
        'Secure multi-gateway payment processing (TAP, Apple Pay)',
        'Shorebird production releases and OTA hot patches',
      ],
      integrations: [
        'Regional Payment Gateways',
        'TAP Gateway',
        'Localization (Arabic/English)',
        'FCM Notifications',
      ],
      paymentGateways: [
        'TAP Payment Gateway',
        'Apple Pay',
        'Visa',
        'Mastercard',
      ],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yaldiet.app&pcampaignid=web_share',
      appStoreUrl: 'https://apps.apple.com/in/app/yal-diet/id6760635122',
      screenshots: ['assets/projects/yaldiet/yaldiet_1.jpg'],
      isFeatured: true,
      accentColor: const Color(0xFF1E3A8A),
    ),

    // 7. Nura Diet (Video Demo Available)
    ProjectModel(
      id: 'nura',
      name: 'Nura Diet',
      category: 'Health & Nutrition',
      clientName: 'Nura Diet Kuwait',
      clientRegion: 'Kuwait 🇰🇼',
      videoAsset: 'assets/projects/nura/video.mp4',
      shortDescription: 'Nutrition and meal delivery mobile app featuring weekend off diet plans, personalized caloric tracking, and referral incentives.',
      fullDescription:
          'Nura Diet provides specialized meal subscription packages (e.g. 104 K.D monthly plans). '
          'Built with comprehensive digital credit wallet support, referral sharing via WhatsApp, and nutritionist consultation.',
      role: 'Flutter Mobile Developer',
      technologies: [
        'Flutter',
        'Dart',
        'REST APIs',
        'Payment Gateways',
        'Referral Logic',
        'WhatsApp API',
      ],
      features: [
        'Monthly diet package discovery with flexible weekend-off options',
        'Referral system (Give 10% Get 10%)',
        'Digital credit wallet for subscription management',
        'Multi-channel customer service and WhatsApp ordering',
      ],
      integrations: [
        'Regional Payment Gateways',
        'WhatsApp Integration',
        'FCM',
      ],
      paymentGateways: ['KNET', 'In-App Wallet Credits', 'Credit Cards'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=cocopalms.nuradiet.app&pcampaignid=web_share',
      screenshots: [
        'assets/projects/nura/nura_1.jpg',
        'assets/projects/nura/nura_2.jpg',
      ],
      isFeatured: false,
      accentColor: const Color(0xFFEC4899),
    ),

    // 8. Steamed (Video Demo Available)
    ProjectModel(
      id: 'steamed',
      name: 'Steamed',
      category: 'Health & Nutrition',
      clientName: 'Steamed Health',
      clientRegion: 'GCC 🌍',
      videoAsset: 'assets/projects/steamed/video.mp4',
      shortDescription: 'Complete health and nutrition partner mobile application with meal plans, macro calculators, and premium culinary aesthetics.',
      fullDescription:
          'Steamed positions itself as "a complete health partner", offering healthy steamed and balanced meal subscriptions. '
          'Engineered with an editorial food photography UI, calorie tracking, BMI calculation, and dynamic subscription packages.',
      role: 'Flutter Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Clean Architecture',
        'REST APIs',
        'BMI & Macro Engine',
      ],
      features: [
        'Bespoke health onboarding and dietary objective setting',
        'Healthy meal plan subscriptions with delivery scheduling',
        'Nutritional transparency (protein, carbs, calories, fats)',
        'Clean, high-contrast dark aesthetic UI',
      ],
      integrations: ['Payment Gateway', 'Firebase FCM', 'REST Backend'],
      paymentGateways: ['Regional Card Gateways', 'Apple Pay'],
      platforms: ['Android', 'iOS'],
      screenshots: [
        'assets/projects/steamed/steamed_1.jpg',
        'assets/projects/steamed/steamed_2.jpg',
        'assets/projects/steamed/steamed_3.jpg',
      ],
      isFeatured: false,
      accentColor: const Color(0xFF10B981),
    ),

    // 9. Traffic Condition Map (Video Demo Available)
    ProjectModel(
      id: 'traffic_map',
      name: 'Traffic Condition Map',
      category: 'Maps & Location',
      clientName: 'Smart Mobility Transit',
      clientRegion: 'Singapore & Malaysia 🇸🇬 🇲🇾',
      videoAsset: 'assets/projects/traffic_app/video.mp4',
      hasMapIntegration: true,
      shortDescription: 'Real-time traffic and route monitoring application utilizing Google Maps SDK with custom markers, coordinates, and live traffic layer overlays.',
      fullDescription:
          'Demonstrates deep integration of Google Maps SDK in Flutter. Features real-time traffic condition rendering, '
          'cross-border checkpoint monitoring (Singapore & Johor Bahru), marker cluster placement, distance calculation algorithms, '
          'and route navigation logic.',
      role: 'Flutter Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Google Maps SDK',
        'Location Services',
        'Geolocator',
        'Routes API',
      ],
      features: [
        'Interactive Google Maps canvas with real-time traffic condition overlay',
        'Custom checkpoint markers and boundary coordinate tracking',
        'Dynamic zoom and distance calculation algorithms',
        'GPS location picker and address geocoding',
      ],
      integrations: [
        'Google Maps Platform',
        'Location Permissions & GPS',
        'Geolocator',
      ],
      paymentGateways: [],
      platforms: ['Android'],
      screenshots: [
        'assets/projects/traffic_app/traffic_app_1.jpg',
        'assets/projects/traffic_app/traffic_app_2.jpg',
      ],
      isFeatured: true,
      accentColor: const Color(0xFFEF4444),
    ),

    // 10. Approved Life KSA
    ProjectModel(
      id: 'approved_life',
      name: 'Approved Life KSA',
      category: 'Health & Nutrition',
      clientName: 'Approved Life KSA',
      clientRegion: 'Saudi Arabia 🇸🇦',
      hasMapIntegration: true,
      shortDescription: 'Certified health and meal subscription platform in Saudi Arabia with mada and Apple Pay integrations.',
      fullDescription:
          'Approved Life KSA serves subscribers across Saudi Arabia with certified meal plans. '
          'Integrated with mada, Visa, Mastercard, and Apple Pay payment gateways, along with SMS OTP verification (Falcon KWT / SMS Easy) and Google Maps address selection.',
      role: 'Flutter Developer',
      technologies: [
        'Flutter',
        'Dart',
        'mada Payment Gateway',
        'Apple Pay',
        'SMS OTP Gateway',
        'Google Maps SDK',
      ],
      features: [
        'KSA regional meal plan subscriptions',
        'mada debit card and Apple Pay integration',
        'SMS OTP verification via regional gateways',
        'Google Maps address and location picker',
      ],
      integrations: [
        'mada Payment',
        'Apple Pay',
        'SMS Gateways (Falcon/SMS Easy)',
        'Google Maps',
      ],
      paymentGateways: ['mada Debit Card', 'Apple Pay', 'Visa', 'Mastercard'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=io.cocopalms.approvedlife&pcampaignid=web_share',
      appStoreUrl:
          'https://apps.apple.com/in/app/approved-life-diet/id6767094688',
      screenshots: [],
      isFeatured: false,
      accentColor: const Color(0xFF059669),
    ),

    // 11. Forma Diet
    ProjectModel(
      id: 'forma_diet',
      name: 'Forma Diet',
      category: 'Health & Nutrition',
      clientName: 'Forma Diet Kuwait',
      clientRegion: 'Kuwait 🇰🇼',
      shortDescription: 'Modern lifestyle nutrition application featuring 3D avatar guided onboarding, monthly meal plans, and Arabic/English language support.',
      fullDescription:
          'Forma Diet guides users on their journey to healthier living with monthly meal plans. '
          'Features interactive onboarding animations, multilingual language support, and seamless payment processing.',
      role: 'Flutter Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Interactive UI',
        'REST APIs',
        'Clean Architecture',
      ],
      features: [
        'Engaging avatar-driven onboarding experience',
        'Subscription plan selection and macro customization',
        'Instant language toggle (AR / EN)',
        'Order tracking and delivery verification',
      ],
      integrations: ['Payment Gateway Integration', 'Firebase Analytics'],
      paymentGateways: ['KNET', 'Credit Cards'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cocopalms.formadiet&pcampaignid=web_share',
      screenshots: [
        'assets/projects/forma_diet/forma_diet_1.jpg',
        'assets/projects/forma_diet/forma_diet_2.jpg',
      ],
      isFeatured: false,
      accentColor: const Color(0xFF38BDF8),
    ),

    // 12. Bizo Diet
    ProjectModel(
      id: 'bizo_diet',
      name: 'Bizo Diet',
      category: 'Health & Nutrition',
      clientName: 'Bizo Suite Platform',
      clientRegion: 'GCC 🌍',
      hasShorebirdOta: true,
      shortDescription: 'Enterprise diet & meal management application part of the Bizo Suite platform for customized health delivery logistics.',
      fullDescription:
          'Bizo Diet is part of the enterprise Bizo Suite ecosystem. '
          'Powers end-to-end diet meal ordering, delivery address mapping, dynamic calorie calculations, and secure payments with automated Shorebird OTA hot patches.',
      role: 'Mobile Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Enterprise Architecture',
        'REST APIs',
        'Shorebird OTA',
      ],
      features: [
        'Enterprise diet ordering and custom meal configuration',
        'Secure token authentication and role management',
        'Dynamic meal pricing calculations',
        'Automated OTA hot patch deployment with Shorebird',
      ],
      integrations: [
        'Enterprise REST Backend',
        'Payment Gateway',
        'Shorebird OTA',
      ],
      paymentGateways: ['Corporate Billing', 'Payment Gateways'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=bizosuite.com&pcampaignid=web_share',
      screenshots: ['assets/projects/bizo_diet/bizo_diet_1.jpg'],
      isFeatured: false,
      accentColor: const Color(0xFF0F766E),
    ),

    // 13. Guilt Free Kitchen
    ProjectModel(
      id: 'guilt_free_kitchen',
      name: 'Guilt Free Kitchen',
      category: 'Health & Nutrition',
      clientName: 'Guilt Free Kitchen',
      clientRegion: 'GCC 🌍',
      hasShorebirdOta: true,
      shortDescription: 'Wholesome gourmet diet meal subscription platform deployed on Google Play Store and Apple App Store.',
      fullDescription:
          'Guilt Free Kitchen delivers clean-eating culinary meal subscriptions. '
          'Engineered with payment gateway workflows, push notifications, and Shorebird OTA update support.',
      role: 'Flutter Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Payment Gateways',
        'FCM',
        'Shorebird OTA',
      ],
      features: [
        'Dietary meal discovery and gourmet health menus',
        'Multi-currency payment gateway integrations',
        'Push notifications for menu updates',
        'Store deployment on Android & iOS',
      ],
      integrations: [
        'Payment Gateways',
        'FCM',
        'Apple Pay / Visa / Mastercard',
      ],
      paymentGateways: ['Apple Pay', 'Visa', 'Mastercard'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cocopalms.GuiltFreeKitchen&pcampaignid=web_share',
      appStoreUrl:
          'https://apps.apple.com/in/app/guilt-free-kitchen/id6785492579',
      screenshots: [],
      isFeatured: false,
      accentColor: const Color(0xFF84CC16),
    ),

    // 14. Diet Steps
    ProjectModel(
      id: 'diet_steps',
      name: 'Diet Steps',
      category: 'Health & Nutrition',
      clientName: 'Diet Steps',
      clientRegion: 'GCC 🌍',
      shortDescription: 'Step-by-step nutrition and dietary habit tracking application released across Google Play and Apple App Store.',
      fullDescription:
          'Diet Steps provides structured meal scheduling, macro tracking, and payment integrations. '
          'Built with Clean Architecture and released to production on both major mobile platforms.',
      role: 'Flutter Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Clean Architecture',
        'Payment Integration',
      ],
      features: [
        'Step-by-step dietary milestone tracking',
        'Monthly subscription management',
        'Seamless checkout with credit cards and regional payment methods',
      ],
      integrations: ['Payment Gateway', 'Firebase Cloud Messaging'],
      paymentGateways: ['Regional Gateways', 'Credit Cards'],
      platforms: ['Android', 'iOS'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cocopalms.dietstepsapp&pcampaignid=web_share',
      appStoreUrl: 'https://apps.apple.com/in/app/diet-steps/id6771322109',
      screenshots: [],
      isFeatured: false,
      accentColor: const Color(0xFFF59E0B),
    ),

    // 15. Balanced Bite
    ProjectModel(
      id: 'balanced_bite',
      name: 'Balanced Bite',
      category: 'Health & Nutrition',
      clientName: 'Balanced Bite',
      clientRegion: 'GCC 🌍',
      hasShorebirdOta: true,
      shortDescription: 'Diet and balanced nutrition application with calorie calculation algorithms and subscription ordering.',
      fullDescription:
          'Balanced Bite enables users to subscribe to customized macro-balanced meal packages. '
          'Built with Clean Architecture, REST APIs, and automated Shorebird OTA patch updates.',
      role: 'Flutter Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Clean Architecture',
        'REST APIs',
        'Shorebird OTA',
      ],
      features: [
        'Nutritional balance calculator and meal customization',
        'Secure checkout and subscription renewal',
        'Push notifications for daily meal choices',
      ],
      integrations: ['Payment Gateway', 'Firebase FCM', 'Shorebird OTA'],
      paymentGateways: ['Payment Gateway', 'Apple Pay'],
      platforms: ['Android', 'iOS'],
      screenshots: [],
      isFeatured: false,
      accentColor: const Color(0xFF14B8A6),
    ),

    // 16. Chum Chum B2B
    ProjectModel(
      id: 'chum_chum',
      name: 'Chum Chum B2B',
      category: 'SaaS & Enterprise',
      clientName: 'Sresht Gyan Tech Solutions',
      clientRegion: 'Thailand 🇹🇭',
      shortDescription: 'Comprehensive B2B e-commerce Flutter application for the Thailand region with wholesale ordering workflows.',
      fullDescription:
          'End-to-end B2B e-commerce mobile application engineered for the Thailand wholesale market. '
          'Implemented product catalogs, volume bulk ordering, cart management, and REST API data pipelines.',
      role: 'Junior Mobile Developer',
      technologies: [
        'Flutter',
        'Dart',
        'Provider',
        'REST APIs',
        'JSON Handling',
        'Responsive UI',
      ],
      features: [
        'Wholesale catalog and volume pricing logic',
        'Cart and dynamic wholesale checkout workflows',
        'REST API sync with high-volume data handling',
        'Responsive layouts across multiple device formats',
      ],
      integrations: [
        'REST Backend',
        'Local Cache',
        'Provider State Management',
      ],
      paymentGateways: ['Regional B2B Bank Transfer', 'PromptPay'],
      platforms: ['Android', 'iOS'],
      screenshots: [],
      isFeatured: false,
      accentColor: const Color(0xFFF97316),
    ),
  ];
}
