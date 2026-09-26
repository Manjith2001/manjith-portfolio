import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/section_header.dart';

class ShorebirdDeploymentSection extends StatelessWidget {
  const ShorebirdDeploymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const SectionHeader(
            tag: 'DevOps & OTA Architecture',
            title: 'Shorebird OTA & Release Architecture',
            subtitle:
                'Hands-on execution of over-the-air (OTA) code push pipelines and production maintenance '
                'across 17 commercial mobile applications on Android and iOS.',
          ),
          const SizedBox(height: 36),

          // Main Spotlight Card
          Container(
            padding: EdgeInsets.all(isMobile ? 22 : 36),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF141416), Color(0xFF101014)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.35),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Badges
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    _buildPill(
                      label: '17 PRODUCTION APPS',
                      icon: Icons.rocket_launch_rounded,
                      color: AppColors.accentEmerald,
                    ),
                    _buildPill(
                      label: 'ANDROID & iOS',
                      icon: Icons.devices_rounded,
                      color: AppColors.accentCyan,
                    ),
                    _buildPill(
                      label: 'SHOREBIRD OTA',
                      icon: Icons.bolt_rounded,
                      color: AppColors.accentAmber,
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Narrative
                Text(
                  'Zero-Downtime Maintenance & Instant Hot Patches',
                  style: isMobile
                      ? AppTypography.h3(size: 20, weight: FontWeight.w700)
                      : AppTypography.h2(size: 24, weight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Text(
                  'Traditional app store review cycles can take days when critical production issues arise. '
                  'By architecting and managing Shorebird release and patch workflows across 17 commercial applications, '
                  'I deliver instant Dart code updates directly to end-user devices with zero app-store delays, '
                  'backed by comprehensive patch validation on physical Android hardware and iOS simulators.',
                  style: AppTypography.body(
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 36),

                // Pipeline Flowchart / Steps
                isMobile
                    ? Column(
                        children: [
                          _buildStep(
                            '01',
                            'Build & Test',
                            'Clean Architecture code with unit & Postman QA',
                            Icons.code_rounded,
                          ),
                          _buildStepArrow(isVertical: true),
                          _buildStep(
                            '02',
                            'Store Release',
                            'Initial binaries deployed to Play Store & App Store',
                            Icons.cloud_upload_rounded,
                          ),
                          _buildStepArrow(isVertical: true),
                          _buildStep(
                            '03',
                            'Patch Testing',
                            'Shorebird patch validation across Android & iOS simulators',
                            Icons.check_circle_outline_rounded,
                          ),
                          _buildStepArrow(isVertical: true),
                          _buildStep(
                            '04',
                            'OTA Code Push',
                            'Instant zero-downtime updates delivered to 17 apps',
                            Icons.bolt_rounded,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _buildStep(
                              '01',
                              'Build & Test',
                              'Clean Architecture code with QA',
                              Icons.code_rounded,
                            ),
                          ),
                          _buildStepArrow(isVertical: false),
                          Expanded(
                            child: _buildStep(
                              '02',
                              'Store Release',
                              'Deployed to Play Store & App Store',
                              Icons.cloud_upload_rounded,
                            ),
                          ),
                          _buildStepArrow(isVertical: false),
                          Expanded(
                            child: _buildStep(
                              '03',
                              'Patch Testing',
                              'Shorebird patch validation on devices',
                              Icons.check_circle_outline_rounded,
                            ),
                          ),
                          _buildStepArrow(isVertical: false),
                          Expanded(
                            child: _buildStep(
                              '04',
                              'OTA Code Push',
                              'Instant zero-downtime updates delivered',
                              Icons.bolt_rounded,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPill({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: AppTypography.mono(
                size: 11,
                color: color,
                weight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(
    String stepNumber,
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stepNumber,
                style: AppTypography.mono(
                  size: 11,
                  color: AppColors.primaryLight,
                ),
              ),
              Icon(icon, size: 18, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTypography.body(
              size: 14,
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: AppTypography.bodySmall(
              size: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepArrow({required bool isVertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isVertical ? 0 : 8,
        vertical: isVertical ? 8 : 0,
      ),
      child: Icon(
        isVertical ? Icons.arrow_downward_rounded : Icons.arrow_forward_rounded,
        size: 18,
        color: AppColors.primaryLight.withValues(alpha: 0.6),
      ),
    );
  }
}
