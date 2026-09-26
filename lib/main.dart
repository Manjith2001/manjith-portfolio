import 'package:flutter/material.dart';

import 'core/constants/personal_info.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/responsive.dart';
import 'presentation/controllers/navigation_controller.dart';
import 'presentation/sections/capabilities/technical_capabilities_section.dart';
import 'presentation/sections/clients/worked_clients_section.dart';
import 'presentation/sections/contact/contact_section.dart';
import 'presentation/sections/education_certifications/education_certifications_section.dart';
import 'presentation/sections/experience/experience_timeline_section.dart';
import 'presentation/sections/footer/app_footer.dart';
import 'presentation/sections/hero/hero_section.dart';
import 'presentation/sections/metrics_banner/production_impact_banner.dart';
import 'presentation/sections/projects/project_case_study_modal.dart';
import 'presentation/sections/projects/projects_section.dart';
import 'presentation/sections/shorebird_spotlight/shorebird_deployment_section.dart';
import 'presentation/sections/skills/skills_matrix_section.dart';
import 'presentation/widgets/ambient_space_background.dart';
import 'presentation/widgets/app_navigation_bar.dart';
import 'presentation/widgets/lightbox_modal.dart';
import 'presentation/widgets/section_reveal.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ManjithPortfolioApp());
}

class ManjithPortfolioApp extends StatelessWidget {
  const ManjithPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${PersonalInfo.name} — ${PersonalInfo.title}',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioHomeScreen(),
    );
  }
}

class PortfolioHomeScreen extends StatefulWidget {
  const PortfolioHomeScreen({super.key});

  @override
  State<PortfolioHomeScreen> createState() => _PortfolioHomeScreenState();
}

class _PortfolioHomeScreenState extends State<PortfolioHomeScreen>
    with SingleTickerProviderStateMixin {
  late final NavigationController _navController;
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _navController = NavigationController();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.025), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    final isTest = WidgetsBinding.instance.runtimeType.toString().contains(
      'TestWidgetsFlutterBinding',
    );
    if (isTest) {
      _entranceController.value = 1.0;
    } else {
      _entranceController.forward();
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // 1. 60fps+ Smooth Hardware-Accelerated Dynamic Ambient Background
          Positioned.fill(
            child: AmbientSpaceBackground(
              scrollController: _navController.scrollController,
            ),
          ),

          // 2. High-Performance Decoupled Scrollable Content Stream with Smooth Opening Entrance
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                controller: _navController.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Top breathing space for sticky navigation
                    const SizedBox(height: 84),

                    // Centered Content Stream
                    Padding(
                      padding: Responsive.horizontalPadding(context),
                      child: Column(
                        children: [
                          // 1. Hero Section
                          SectionReveal(
                            index: 0,
                            child: Container(
                              key: _navController.heroKey,
                              child: HeroSection(navController: _navController),
                            ),
                          ),

                          // 2. Production Impact Metrics Banner
                          SectionReveal(
                            index: 1,
                            child: Container(
                              key: _navController.appsKey,
                              child: const ProductionImpactBanner(),
                            ),
                          ),

                          // 3. Worked Clients & Commercial Brands
                          SectionReveal(
                            index: 2,
                            child: Container(
                              key: _navController.clientsKey,
                              child: const WorkedClientsSection(),
                            ),
                          ),

                          // 4. Commercial Projects & 60fps Video Demos Showcase
                          SectionReveal(
                            index: 3,
                            child: Container(
                              key: _navController.projectsKey,
                              child: ProjectsSection(
                                navController: _navController,
                              ),
                            ),
                          ),

                          // 5. Engineering Capabilities
                          SectionReveal(
                            index: 4,
                            child: Container(
                              key: _navController.capabilitiesKey,
                              child: const TechnicalCapabilitiesSection(),
                            ),
                          ),

                          // 6. Shorebird OTA & Production Deployment Spotlight
                          SectionReveal(
                            index: 5,
                            child: Container(
                              key: _navController.shorebirdKey,
                              child: const ShorebirdDeploymentSection(),
                            ),
                          ),

                          // 7. Verified Technical Skills Matrix
                          SectionReveal(
                            index: 6,
                            child: Container(
                              key: _navController.skillsKey,
                              child: const SkillsMatrixSection(),
                            ),
                          ),

                          // 8. Commercial Industry Experience Timeline
                          SectionReveal(
                            index: 7,
                            child: Container(
                              key: _navController.experienceKey,
                              child: const ExperienceTimelineSection(),
                            ),
                          ),

                          // 9. Education & Credentials
                          SectionReveal(
                            index: 8,
                            child: Container(
                              key: _navController.educationKey,
                              child: const EducationCertificationsSection(),
                            ),
                          ),

                          // 10. Direct Contact Section
                          SectionReveal(
                            index: 9,
                            child: Container(
                              key: _navController.contactKey,
                              child: const ContactSection(),
                            ),
                          ),

                          const SizedBox(height: 60),
                        ],
                      ),
                    ),

                    // 11. Footer
                    AppFooter(navController: _navController),
                  ],
                ),
              ),
            ),
          ),

          // 3. Sticky Glassmorphic Navigation Bar at Top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _navController,
              builder: (context, _) =>
                  AppNavigationBar(navController: _navController),
            ),
          ),

          // 4. Interactive Project Case Study & Video Player Modal
          AnimatedBuilder(
            animation: _navController,
            builder: (context, _) {
              if (_navController.selectedProject == null) {
                return const SizedBox.shrink();
              }
              return Positioned.fill(
                child: ProjectCaseStudyModal(navController: _navController),
              );
            },
          ),

          // 5. Fullscreen Lightbox Modal
          AnimatedBuilder(
            animation: _navController,
            builder: (context, _) {
              if (!_navController.isLightboxOpen) {
                return const SizedBox.shrink();
              }
              return Positioned.fill(
                child: LightboxModal(navController: _navController),
              );
            },
          ),
        ],
      ),
    );
  }
}
