import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/personal_info.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';

class ProductionImpactBanner extends StatelessWidget {
  const ProductionImpactBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final width = MediaQuery.of(context).size.width;

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 36,
        vertical: 16,
      ),
      child: Column(
        children: [
          // Metrics Row as Floating Pods
          width < 980
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricPod(
                            PersonalInfo.productionAppsCount,
                            'Production Apps',
                            'Google Play & App Store',
                            Icons.rocket_launch_rounded,
                            AppColors.primaryLight,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMetricPod(
                            '${PersonalInfo.yearsOfExperience} Yrs',
                            'Software Experience',
                            'Mobile & Frontend',
                            Icons.work_history_rounded,
                            AppColors.accentCyan,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricPod(
                            PersonalInfo.paymentGatewaysCount,
                            'Payment Gateways',
                            'International & Regional',
                            Icons.payments_rounded,
                            AppColors.accentEmerald,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMetricPod(
                            '17 Apps',
                            'Shorebird OTA',
                            'Instant Hot Patches',
                            Icons.bolt_rounded,
                            AppColors.accentAmber,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Builder(
                  builder: (context) {
                    final metricRow = Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildMetricPod(
                            PersonalInfo.productionAppsCount,
                            'Production Apps',
                            'Google Play & App Store',
                            Icons.rocket_launch_rounded,
                            AppColors.primaryLight,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMetricPod(
                            '${PersonalInfo.yearsOfExperience} Yrs',
                            'Software Experience',
                            'Mobile & Frontend',
                            Icons.work_history_rounded,
                            AppColors.accentCyan,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMetricPod(
                            PersonalInfo.paymentGatewaysCount,
                            'Payment Gateways',
                            'International & Regional',
                            Icons.payments_rounded,
                            AppColors.accentEmerald,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMetricPod(
                            '17 Apps',
                            'Shorebird OTA',
                            'Instant Hot Patches',
                            Icons.bolt_rounded,
                            AppColors.accentAmber,
                          ),
                        ),
                      ],
                    );
                    return Responsive.isTest
                        ? metricRow
                        : metricRow.animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0);
                  },
                ),

          const SizedBox(height: 32),

          // Application names ticker / list as small pills
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VERIFIED PRODUCTION ROSTER:',
                      style: AppTypography.mono(
                        size: 11,
                        color: AppColors.textMuted,
                        weight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _buildAppBadges(),
                      ),
                    ),
                  ],
                )
              : Builder(
                  builder: (context) {
                    final rosterRow = Row(
                      children: [
                        Text(
                          'VERIFIED PRODUCTION ROSTER:',
                          style: AppTypography.mono(
                            size: 11,
                            color: AppColors.textMuted,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _buildAppBadges(),
                            ),
                          ),
                        ),
                      ],
                    );
                    return Responsive.isTest
                        ? rosterRow
                        : rosterRow.animate().fadeIn(duration: 600.ms, delay: 200.ms);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildMetricPod(
    String value,
    String label,
    String subtext,
    IconData icon,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: AppTypography.h2(
              size: 28,
              weight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: AppTypography.mono(
              size: 11,
              weight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtext,
            style: AppTypography.bodySmall(
              size: 11,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAppBadges() {
    final apps = [
      'Enkage (Wallet & Offers)',
      'Rentings (Property SaaS)',
      'Steamed (Nutrition)',
      'Under Thirty Diet',
      'Traffic Condition Map',
      'YalDiet',
      'Healthy Diet',
      'Nura Diet',
      'Forma Diet',
      'Bizo Diet',
      'Guilt Free Kitchen',
      'Diet Steps',
      'The Champions Diet',
      'Approved Life KSA',
      'Balanced Bite',
      'Pure Health',
      'Calculate Diet',
      'Chum Chum (B2B E-Commerce)',
    ];

    return apps.map((app) => _buildAppBadge(app)).toList();
  }

  Widget _buildAppBadge(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(100), // Pill shape
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      child: Text(
        name,
        style: AppTypography.bodySmall(
          size: 11,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
