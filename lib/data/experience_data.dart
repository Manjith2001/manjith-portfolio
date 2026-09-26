import '../models/experience_model.dart';

class ExperienceData {
  static final List<ExperienceModel> experiences = [
    ExperienceModel(
      company: 'Cocopalms Information Technology and Services',
      role: 'Mobile Developer & Frontend',
      period: 'Dec 2025 – Present',
      location: 'Thiruvananthapuram, Kerala, India',
      isCurrent: true,
      highlightSummary:
          '17+ Production Apps deployed across Google Play Store & Apple App Store. Personally handled Shorebird OTA release workflows.',
      keyTechnologies: [
        'Flutter',
        'Dart',
        'Clean Architecture',
        'Riverpod',
        'Provider',
        'GetX',
        'Shorebird',
        'REST / GraphQL',
        'Payment Gateways',
        'Google Maps',
        'Firebase FCM',
      ],
      responsibilities: [
        'Develop and maintain Flutter applications for Android and iOS using Clean Architecture, MVVM/MVC patterns and GetX, Provider and Riverpod.',
        'Worked on 17+ production applications released through Google Play Store and Apple App Store, including YalDiet, Healthy Diet, Bizo Diet, Approved Life KSA, Balanced Bite, Dietsteps, Calculate Diet, Carbs, Champions Diet, Guilt Free Kitchen, Nura, Prime Fuel Diet, Pure Health, Steamed, Under Thirty Diet, Engage (Enkage) and Rentings.',
        'Implement JWT/Bearer-token authentication, REST/GraphQL integrations, JSON handling and backend API workflows.',
        'Integrated payment gateways including Razorpay, QPay, SkipCash, MyFatoorah, TAP, Visa, Mastercard, Apple Pay and mada using SDKs, WebView redirection and backend APIs.',
        'Implemented SMS/email OTP verification and integrated FCC Falcon KWT SMS, SMS Easy and MSG91 gateways.',
        'Implemented Firebase Cloud Messaging push notifications and Firebase Analytics.',
        'Implemented Google Maps features including location selection, address/location picker, markers, distance calculation and routes/navigation.',
        'Implemented biometric authentication including fingerprint and Face ID, along with camera, QR-code generation and local/secure storage.',
        'Implemented business and mathematical logic for calorie, BMI, macro/nutrient, age/weight/height, subscription, meal and dynamic pricing calculations.',
        'Personally handled Shorebird production release and patch workflows across 17 applications and performed patch testing.',
        'Implemented PDF generation/viewing/downloading and multilingual language translations.',
        'Optimized application performance, UI responsiveness and memory usage; debugged and resolved production issues.',
        'Performed API testing with Postman and supported Flutter unit, widget, integration, regression and manual testing.',
        'Contributed to Android and iOS release/deployment processes and production support.',
        'Used Claude, Cursor and Antigravity as AI-assisted development tools.',
        'Worked with Git, GitLab and GitHub for source control and collaboration.',
      ],
    ),
    ExperienceModel(
      company: 'Sresht Gyan Tech Solutions',
      role: 'Junior Developer',
      period: 'Aug 2024 – Dec 2025',
      isCurrent: false,
      highlightSummary:
          'Built and maintained Chum Chum, a comprehensive B2B e-commerce Flutter application for the Thailand region.',
      keyTechnologies: ['Flutter', 'Dart', 'Provider', 'REST APIs', 'JSON Handling', 'Responsive UI'],
      responsibilities: [
        'Built and maintained Chum Chum, a B2B e-commerce Flutter application for the Thailand region, developed end-to-end and continuously maintained.',
        'Worked on product management, cart functionality and wholesale order workflows.',
        'Implemented Provider-based state management and integrated REST APIs with JSON data handling.',
        'Built reusable Flutter widgets and responsive UI components.',
        'Performed bug fixing, testing, performance improvements and ongoing application maintenance.',
      ],
    ),
    ExperienceModel(
      company: 'MashupStack',
      role: 'Java Full Stack Developer Intern',
      period: 'Aug 2023 – Jul 2024',
      isCurrent: false,
      highlightSummary: 'Full-stack application development with Java, Spring Boot, and React.',
      keyTechnologies: ['Java', 'Spring Boot', 'React', 'REST APIs', 'SQL / Databases'],
      responsibilities: [
        'Developed web applications using Java, Spring Boot and React.',
        'Worked with REST APIs, databases and application deployment workflows.',
        'Supported end-to-end development and debugging of full-stack web applications.',
      ],
    ),
  ];
}

