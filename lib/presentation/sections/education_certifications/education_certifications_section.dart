import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/education_data.dart';
import '../../widgets/section_header.dart';

class EducationCertificationsSection extends StatelessWidget {
  const EducationCertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const SectionHeader(
            tag: 'Education & Credentials',
            title: 'Education & Certifications',
            subtitle: 'Academic foundations in Computer Science and continuous professional certifications.',
          ),
          const SizedBox(height: 36),

          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _buildEducationList()),
                    const SizedBox(width: 32),
                    Expanded(flex: 6, child: _buildCertificationsList()),
                  ],
                )
              : Column(
                  children: [
                    _buildEducationList(),
                    const SizedBox(height: 32),
                    _buildCertificationsList(),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildEducationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.school_outlined,
              size: 20,
              color: AppColors.primaryLight,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Education',
                style: AppTypography.h3(size: 18, weight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: EducationData.educationList.map((edu) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          edu.degree,
                          style: AppTypography.body(
                            size: 15,
                            weight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Text(
                          edu.date,
                          style: AppTypography.mono(
                            size: 11,
                            color: AppColors.accentCyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    edu.institution,
                    style: AppTypography.bodySmall(
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    edu.location,
                    style: AppTypography.bodySmall(
                      size: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCertificationsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.verified_outlined,
              size: 20,
              color: AppColors.accentEmerald,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Certifications & Workshops',
                style: AppTypography.h3(size: 18, weight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: EducationData.certifications.map((cert) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: Row(
                children: [
                  Icon(cert.icon, size: 18, color: AppColors.primaryLight),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cert.title,
                          style: AppTypography.body(
                            size: 13,
                            weight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${cert.issuer} • ${cert.date}',
                          style: AppTypography.bodySmall(
                            size: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
