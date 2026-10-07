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
          const SizedBox(height: 48),

          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _buildEducationList()),
                    const SizedBox(width: 48),
                    Expanded(flex: 6, child: _buildCertificationsList()),
                  ],
                )
              : Column(
                  children: [
                    _buildEducationList(),
                    const SizedBox(height: 48),
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
              size: 24,
              color: AppColors.primaryLight,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Education',
                style: AppTypography.h3(size: 22, weight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Column(
          children: EducationData.educationList.map((edu) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          edu.degree,
                          style: AppTypography.body(
                            size: 16,
                            weight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          edu.institution,
                          style: AppTypography.body(
                            size: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              edu.date,
                              style: AppTypography.mono(
                                size: 12,
                                color: AppColors.accentCyan,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '•',
                              style: TextStyle(color: AppColors.borderLight),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                edu.location,
                                style: AppTypography.bodySmall(
                                  size: 12,
                                  color: AppColors.textMuted,
                                ),
                                overflow: TextOverflow.ellipsis,
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
              size: 24,
              color: AppColors.accentEmerald,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Certifications & Workshops',
                style: AppTypography.h3(size: 22, weight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: EducationData.certifications.map((cert) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.borderLight, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(cert.icon, size: 16, color: AppColors.primaryLight),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                cert.title,
                                style: AppTypography.body(
                                  size: 13,
                                  weight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${cert.issuer} • ${cert.date}',
                                style: AppTypography.bodySmall(
                                  size: 11,
                                  color: AppColors.textMuted,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
