# manjith_portfolio
# Manjith Hemachandran — Premium Flutter Developer Portfolio

A new Flutter project.
> **High-Performance Flutter Web Portfolio** built for **Manjith Hemachandran**, Flutter Mobile Application Developer with 2.5+ years of software development experience and 17+ commercial applications deployed on Google Play Store and Apple App Store.

## Getting Started
Designed with an **Awwwards / Apple-grade editorial aesthetic**, zero generic templates, zero fabricated metrics, and production-grade responsive architecture.

This project is a starting point for a Flutter application.
---

A few resources to get you started if this is your first Flutter project:
## 🌟 Key Highlights & Engineering Features

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)
- **Production Track Record**: Comprehensive showcase of 17+ live commercial mobile applications with verified App Store and Google Play Store links.
- **Editorial Visual Design**: Bespoke Obsidian dark mode theme (`#090B10`), dynamic indigo/cyan neon accents, refined typography, and subtle ambient card glows.
- **Interactive Device Showcases**: Asymmetric screenshot presentation with live device frames, hover zoom, and full-screen image modal with keyboard/tap dismiss.
- **Deep Case Study Dialogs**: Modular bottom-sheet modal detailing each app's role, category, architecture, technical challenges, and live store links.
- **Beyond UI — Engineering Capabilities**: Highlights Clean Architecture (MVVM/BLoC), 9+ Payment Gateway Integrations (MyFatoorah, Tap, Stripe, Tamara, Tabby, Apple Pay, Google Pay), Google Maps SDK real-time tracking, Math/dietary engines, and Biometrics.
- **Shorebird OTA Spotlight**: Visual interactive flowchart of the over-the-air zero-downtime deployment pipeline used across production client apps.
- **Zero Fake Percentages**: Clustered technical competency badges organized by domain (Mobile, Frontend, Backend & Cloud, Architecture & State, Tools & DevOps).
- **Sticky Blur Navigation**: Sleek glassmorphism header that compresses dynamically on scroll, highlighting the active section with smooth navigation.
- **Multi-Viewport Responsive**: 100% fluid across 4K displays, ultrawides, standard laptops, tablets (iPad/Surface), and mobile devices (iPhone/Pixel).
- **Direct Resume Access**: Static one-click PDF download served at `/manjith_hemachandran_resume.pdf`.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
---

## 🏗️ Architecture & Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_strings.dart
│   │   └── personal_info.dart           # Factual data from resume
│   ├── theme/
│   │   ├── app_colors.dart              # Obsidian theme & accent tokens
│   │   ├── app_theme.dart               # Material 3 ThemeData definition
│   │   ├── app_typography.dart          # Plus Jakarta Sans & JetBrains Mono
│   │   └── brand_icons.dart             # Lightweight native icon abstraction
│   └── utils/
│       ├── responsive.dart              # Desktop/Tablet/Mobile breakpoints
│       └── url_helper.dart              # Store, mail, tel, & resume launcher
├── data/
│   ├── models/
│   │   ├── project_model.dart           # Structured data model for 17+ apps
│   │   └── experience_model.dart        # Timeline model
│   └── repositories/
│       ├── projects_data.dart           # Verified 17+ apps with store links
│       ├── experience_data.dart         # Cocopalms, Sresht Gyan, MashupStack
│       ├── skills_data.dart             # Categorized skill badges
│       ├── capabilities_data.dart       # Beyond UI engineering highlights
│       └── education_data.dart          # Degree & certifications
└── presentation/
    ├── controllers/
    │   └── navigation_controller.dart   # Smooth scrolling & modal state
    ├── sections/
    │   ├── hero/                        # Editorial portrait & high-impact intro
    │   ├── metrics_banner/              # 17+ apps, 9+ gateways, 2 platforms
    │   ├── projects/                    # Filterable project grid & modal
    │   ├── capabilities/                # "Beyond UI" cards
    │   ├── shorebird_spotlight/         # OTA code push visual pipeline
    │   ├── skills/                      # Clustered skill matrices
    │   ├── experience/                  # Verified career timeline
    │   ├── education_certifications/    # CS degree & workshops
    │   ├── contact/                     # Inquiry form & direct links
    │   └── footer/                      # Brand footer & back-to-top
    └── widgets/
        ├── app_navigation_bar.dart      # Sticky glass navbar
        ├── custom_button.dart           # Accessible animated buttons
        ├── tech_chip.dart               # Monospace tech badges
        ├── section_header.dart          # Editorial section titles
        └── lightbox_modal.dart          # Fullscreen image inspector
```

---

## 🚀 Running the Project Locally

### Prerequisites
- Flutter SDK (3.22.0 or higher recommended, tested on Flutter 3.47.5 / Dart 3.13.4)
- Google Chrome or Edge browser
- Node.js (for preview server, optional)

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run in Development Mode
```bash
flutter run -d chrome
```

### 3. Run Automated Tests
```bash
flutter test
```
*Tests verify layout rendering across Desktop (1440x900), Tablet (820x1180), and Mobile (390x844) viewports without overflows.*

---

## 📦 Building for Production

### Build Web Release Bundle
```bash
flutter build web --release
```
The optimized production output will be generated in `build/web/`.

### Preview the Production Build Locally
```bash
node server.js
```
Then visit: [http://localhost:8080](http://localhost:8080)

---

## 🌐 Deployment Options

### 1. GitHub Pages
1. Build the web app: `flutter build web --release --base-href "/manjith-portfolio/"`
2. Push `build/web` to your repository's `gh-pages` branch.

### 2. Firebase Hosting
```bash
firebase init hosting
# Set public directory to: build/web
# Configure as single-page app: Yes
firebase deploy
```

### 3. Vercel
```bash
vercel deploy --prod --cwd build/web
```

### 4. Netlify
Drop the `build/web` folder directly into Netlify's web deploy dashboard, or connect your repository with build command `flutter build web --release` and publish directory `build/web`.

---

## 📄 License & Attribution
Designed and engineered for **Manjith Hemachandran**.  
All rights reserved © 2026.
