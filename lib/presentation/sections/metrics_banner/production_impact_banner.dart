import 'package:flutter/material.dart';

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
        vertical: isMobile ? 24 : 32,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          // Metrics Row
          width < 980
              ? Column(
                  children: [
                    _buildMetricItem(
                      PersonalInfo.productionAppsCount,
                      'Production Apps',
                      'Google Play & App Store',
                      Icons.rocket_launch_rounded,
                      AppColors.primaryLight,
                    ),
                    const Divider(color: AppColors.border, height: 32),
                    _buildMetricItem(
                      '${PersonalInfo.yearsOfExperience} Yrs',
                      'Software Experience',
                      'Mobile & Frontend',
                      Icons.work_history_rounded,
                      AppColors.accentCyan,
                    ),
                    const Divider(color: AppColors.border, height: 32),
                    _buildMetricItem(
                      PersonalInfo.paymentGatewaysCount,
                      'Payment Gateways',
                      'International & Regional',
                      Icons.payments_rounded,
                      AppColors.accentEmerald,
                    ),
                    const Divider(color: AppColors.border, height: 32),
                    _buildMetricItem(
                      '17 Apps',
                      'Shorebird OTA',
                      'Instant Hot Patches',
                      Icons.bolt_rounded,
                      AppColors.accentAmber,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildMetricItem(
                        PersonalInfo.productionAppsCount,
                        'Production Apps',
                        'Google Play & App Store',
                        Icons.rocket_launch_rounded,
                        AppColors.primaryLight,
                      ),
                    ),
                    _buildVerticalDivider(),
                    Expanded(
                      child: _buildMetricItem(
                        '${PersonalInfo.yearsOfExperience} Yrs',
                        'Software Experience',
                        'Mobile & Frontend',
                        Icons.work_history_rounded,
                        AppColors.accentCyan,
                      ),
                    ),
                    _buildVerticalDivider(),
                    Expanded(
                      child: _buildMetricItem(
                        PersonalInfo.paymentGatewaysCount,
                        'Payment Gateways',
                        'International & Regional',
                        Icons.payments_rounded,
                        AppColors.accentEmerald,
                      ),
                    ),
                    _buildVerticalDivider(),
                    Expanded(
                      child: _buildMetricItem(
                        '17 Apps',
                        'Shorebird OTA',
                        'Instant Hot Patches',
                        Icons.bolt_rounded,
                        AppColors.accentAmber,
                      ),
                    ),
                  ],
                ),

          const SizedBox(height: 28),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 20),

          // Application names ticker / list
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
                        children: [
                          _buildAppBadge('Enkage (Wallet & Offers)'),
                          _buildAppBadge('Rentings (Property SaaS)'),
                          _buildAppBadge('Steamed (Nutrition)'),
                          _buildAppBadge('Under Thirty Diet'),
                          _buildAppBadge('Traffic Condition Map'),
                          _buildAppBadge('YalDiet'),
                          _buildAppBadge('Healthy Diet'),
                          _buildAppBadge('Nura Diet'),
                          _buildAppBadge('Forma Diet'),
                          _buildAppBadge('Bizo Diet'),
                          _buildAppBadge('Guilt Free Kitchen'),
                          _buildAppBadge('Diet Steps'),
                          _buildAppBadge('The Champions Diet'),
                          _buildAppBadge('Approved Life KSA'),
                          _buildAppBadge('Balanced Bite'),
                          _buildAppBadge('Pure Health'),
                          _buildAppBadge('Calculate Diet'),
                          _buildAppBadge('Chum Chum (B2B E-Commerce)'),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      'VERIFIED PRODUCTION ROSTER:',
                      style: AppTypography.mono(
                        size: 11,
                        color: AppColors.textMuted,
                        weight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildAppBadge('Enkage (Wallet & Offers)'),
                            _buildAppBadge('Rentings (Property SaaS)'),
                            _buildAppBadge('Steamed (Nutrition)'),
                            _buildAppBadge('Under Thirty Diet'),
                            _buildAppBadge('Traffic Condition Map'),
                            _buildAppBadge('YalDiet'),
                            _buildAppBadge('Healthy Diet'),
                            _buildAppBadge('Nura Diet'),
                            _buildAppBadge('Forma Diet'),
                            _buildAppBadge('Bizo Diet'),
                            _buildAppBadge('Guilt Free Kitchen'),
                            _buildAppBadge('Diet Steps'),
                            _buildAppBadge('The Champions Diet'),
                            _buildAppBadge('Approved Life KSA'),
                            _buildAppBadge('Balanced Bite'),
                            _buildAppBadge('Pure Health'),
                            _buildAppBadge('Calculate Diet'),
                            _buildAppBadge('Chum Chum (B2B E-Commerce)'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
    String value,
    String label,
    String subtext,
    IconData icon,
    Color accentColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Icon(icon, color: accentColor, size: 24),
        ),
        const SizedBox(width: 14),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: AppTypography.h2(
                  size: 26,
                  weight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: AppTypography.body(
                  size: 13,
                  weight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                subtext,
                style: AppTypography.bodySmall(
                  size: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 48,
      width: 1,
      color: AppColors.border,
      margin: const EdgeInsets.symmetric(horizontal: 12),
    );
  }

  Widget _buildAppBadge(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderSubtle, width: 1),
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
