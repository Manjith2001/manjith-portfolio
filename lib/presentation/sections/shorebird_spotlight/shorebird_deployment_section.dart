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
          const SizedBox(height: 48),

          // Main Tablet Surface Container
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 48),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F13), // Deep surface
              borderRadius: BorderRadius.circular(32), // Tablet radius
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 40,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Badges as Pills
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
                const SizedBox(height: 32),

                // Narrative
                Text(
                  'Zero-Downtime Maintenance & Instant Hot Patches',
                  style: isMobile
                      ? AppTypography.h3(size: 20, weight: FontWeight.w700)
                      : AppTypography.h2(size: 28, weight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Text(
                  'Traditional app store review cycles can take days when critical production issues arise. '
                  'By architecting and managing Shorebird release and patch workflows across 17 commercial applications, '
                  'I deliver instant Dart code updates directly to end-user devices with zero app-store delays, '
                  'backed by comprehensive patch validation on physical Android hardware and iOS simulators.',
                  style: AppTypography.bodyLarge(
                    size: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 48),

                // Pipeline Flowchart / Steps as interconnected pills/pods
                isMobile
                    ? Column(
                        children: [
                          _buildStepPod(
                            '01',
                            'Build & Test',
                            'Clean Architecture code with unit & Postman QA',
                            Icons.code_rounded,
                          ),
                          _buildStepArrow(isVertical: true),
                          _buildStepPod(
                            '02',
                            'Store Release',
                            'Initial binaries deployed to Play Store & App Store',
                            Icons.cloud_upload_rounded,
                          ),
                          _buildStepArrow(isVertical: true),
                          _buildStepPod(
                            '03',
                            'Patch Testing',
                            'Shorebird patch validation across Android & iOS simulators',
                            Icons.check_circle_outline_rounded,
                          ),
                          _buildStepArrow(isVertical: true),
                          _buildStepPod(
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
                            child: _buildStepPod(
                              '01',
                              'Build & Test',
                              'Clean Architecture code with QA',
                              Icons.code_rounded,
                            ),
                          ),
                          _buildStepArrow(isVertical: false),
                          Expanded(
                            child: _buildStepPod(
                              '02',
                              'Store Release',
                              'Deployed to Play Store & App Store',
                              Icons.cloud_upload_rounded,
                            ),
                          ),
                          _buildStepArrow(isVertical: false),
                          Expanded(
                            child: _buildStepPod(
                              '03',
                              'Patch Testing',
                              'Shorebird patch validation on devices',
                              Icons.check_circle_outline_rounded,
                            ),
                          ),
                          _buildStepArrow(isVertical: false),
                          Expanded(
                            child: _buildStepPod(
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100), // Pill shape
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
                weight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepPod(
    String stepNumber,
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20), // Pod shape
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  stepNumber,
                  style: AppTypography.mono(
                    size: 11,
                    color: AppColors.primaryLight,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(icon, size: 20, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTypography.body(
              size: 15,
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isVertical ? 0 : 12,
        vertical: isVertical ? 12 : 0,
      ),
      child: Icon(
        isVertical ? Icons.arrow_downward_rounded : Icons.arrow_forward_rounded,
        size: 20,
        color: AppColors.borderLight,
      ),
    );
  }
}
