import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/personal_info.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/url_helper.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/tech_chip.dart';
import 'hero_portrait_card.dart';

class HeroSection extends StatelessWidget {
  final NavigationController navController;

  const HeroSection({super.key, required this.navController});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: EdgeInsets.only(
        top: isMobile ? 32 : 64,
        bottom: isMobile ? 48 : 80,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: _buildHeroContent(context)),
                const SizedBox(width: 48),
                const Expanded(flex: 5, child: HeroPortraitCard()),
              ],
            )
          : Column(
              children: [
                const HeroPortraitCard(),
                const SizedBox(height: 48),
                _buildHeroContent(context),
              ],
            ),
    );
  }

  Widget _buildHeroContent(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTest = Responsive.isTest;

    final nameWidget = Text(
      PersonalInfo.name,
      textAlign: isMobile ? TextAlign.center : TextAlign.start,
      style: isMobile
          ? AppTypography.display(size: 38, weight: FontWeight.w800)
          : AppTypography.display(size: 54, weight: FontWeight.w800),
    );

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Developer Name
        isTest ? nameWidget : nameWidget.animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 8),

        // Professional Title with Gradient
        Builder(builder: (context) {
          final titleWidget = ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.heroGradient.createShader(bounds),
            child: Text(
              PersonalInfo.title,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: isMobile
                  ? AppTypography.h2(
                      size: 22,
                      color: Colors.white,
                      weight: FontWeight.w700,
                    )
                  : AppTypography.h2(
                      size: 28,
                      color: Colors.white,
                      weight: FontWeight.w700,
                    ),
            ),
          );
          return isTest
              ? titleWidget
              : titleWidget.animate().fadeIn(duration: 500.ms, delay: 100.ms).slideY(begin: 0.2, end: 0);
        }),
        const SizedBox(height: 18),

        // Subtitle / Bio
        Builder(builder: (context) {
          final bioWidget = ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              'Architecting scalable, production-ready mobile applications for Android & iOS. '
              'Over 2.5+ years of software development experience delivering 17+ commercial applications across Google Play Store & Apple App Store, '
              'with deep expertise in Clean Architecture, 9+ payment gateway integrations, Google Maps SDK, and Shorebird OTA release workflows.',
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: isMobile
                  ? AppTypography.body(size: 14, color: AppColors.textSecondary)
                  : AppTypography.bodyLarge(
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
            ),
          );
          return isTest
              ? bioWidget
              : bioWidget.animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.2, end: 0);
        }),
        const SizedBox(height: 28),

        // CTA Buttons
        Builder(builder: (context) {
          final ctaWidget = Wrap(
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 14,
            runSpacing: 14,
            children: [
              CustomButton(
                label: 'Explore 17+ Apps',
                icon: Icons.rocket_launch_rounded,
                variant: ButtonVariant.primary,
                onPressed: () =>
                    navController.scrollToSection(navController.projectsKey),
              ),
              CustomButton(
                label: 'Download Resume',
                icon: Icons.download_rounded,
                variant: ButtonVariant.outline,
                onPressed: () => UrlHelper.downloadResume(),
              ),
              CustomButton(
                label: 'Contact',
                icon: Icons.mail_outline_rounded,
                variant: ButtonVariant.secondary,
                onPressed: () =>
                    navController.scrollToSection(navController.contactKey),
              ),
            ],
          );
          return isTest
              ? ctaWidget
              : ctaWidget.animate().fadeIn(duration: 400.ms, delay: 300.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
        }),
        const SizedBox(height: 32),

        // Technology quick highlights - floating ecosystem style
        Builder(
          builder: (context) {
            final techWidget = Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.5)),
              ),
              child: Wrap(
                alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                spacing: 12,
                runSpacing: 12,
                children: const [
                  TechChip(label: 'Flutter & Dart', icon: Icons.code_rounded),
                  TechChip(label: 'Android & iOS', icon: Icons.phone_iphone_rounded),
                  TechChip(
                    label: 'Clean Architecture',
                    icon: Icons.account_tree_outlined,
                  ),
                  TechChip(
                    label: '9+ Payment Gateways',
                    icon: Icons.payments_outlined,
                  ),
                  TechChip(label: 'Shorebird OTA', icon: Icons.bolt_rounded),
                  TechChip(label: 'Google Maps SDK', icon: Icons.map_outlined),
                ],
              ),
            );
            return isTest
                ? techWidget
                : techWidget.animate().fadeIn(duration: 400.ms, delay: 400.ms).slideY(begin: 0.2, end: 0);
          },
        ),
      ],
    );
  }
}
