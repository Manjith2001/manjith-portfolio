import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/experience_data.dart';
import '../../../models/experience_model.dart';
import '../../widgets/section_header.dart';
import '../../widgets/tech_chip.dart';

class ExperienceTimelineSection extends StatelessWidget {
  const ExperienceTimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const SectionHeader(
            tag: 'Career Experience',
            title: 'Experience Timeline',
            subtitle:
                'Demonstrated industry engineering background. Full accountability from client requirements '
                'and architectural design to live production deployment on Google Play and Apple App Store.',
          ),
          const SizedBox(height: 36),

          // Timeline Cards List
          Column(
            children: ExperienceData.experiences.map((exp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _ExperienceTimelineCard(experience: exp),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ExperienceTimelineCard extends StatefulWidget {
  final ExperienceModel experience;

  const _ExperienceTimelineCard({required this.experience});

  @override
  State<_ExperienceTimelineCard> createState() =>
      _ExperienceTimelineCardState();
}

class _ExperienceTimelineCardState extends State<_ExperienceTimelineCard> {
  bool _isHovered = false;
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(isMobile ? 20 : 30),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.cardHover : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: exp.isCurrent
                ? (_isHovered
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.4))
                : (_isHovered ? AppColors.borderLight : AppColors.border),
            width: exp.isCurrent ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? AppColors.cardHoverShadow
              : AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Role, Company, Period
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRoleAndBadges(exp),
                      const SizedBox(height: 8),
                      Text(
                        exp.company,
                        style: AppTypography.h3(
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildPeriodPill(exp),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRoleAndBadges(exp),
                            const SizedBox(height: 6),
                            Text(
                              exp.company,
                              style: AppTypography.h3(
                                size: 20,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildPeriodPill(exp),
                    ],
                  ),
            const SizedBox(height: 16),

            // Highlight Summary
            if (exp.highlightSummary != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: Text(
                  exp.highlightSummary!,
                  style: AppTypography.bodySmall(
                    size: 13,
                    color: exp.isCurrent
                        ? AppColors.primaryLight
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Responsibilities Bullet List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: exp.responsibilities
                  .take(_isExpanded ? exp.responsibilities.length : 3)
                  .map((bullet) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: exp.isCurrent
                                  ? AppColors.primary
                                  : AppColors.textMuted,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              bullet,
                              style: AppTypography.body(
                                size: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                  .toList(),
            ),

            if (exp.responsibilities.length > 3) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    _isExpanded
                        ? 'Show Less ↑'
                        : 'Show All Responsibilities (${exp.responsibilities.length}) ↓',
                    style: AppTypography.button(
                      color: AppColors.primaryLight,
                      size: 12,
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),
            const Divider(color: AppColors.border, height: 1),
            const SizedBox(height: 16),

            // Technologies
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: exp.keyTechnologies
                  .map((t) => TechChip(label: t))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleAndBadges(ExperienceModel exp) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 6,
      children: [
        Text(
          exp.role,
          style: AppTypography.h3(
            size: 19,
            weight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (exp.isCurrent) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.accentEmerald.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.accentEmerald.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.accentEmerald,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'CURRENT',
                  style: AppTypography.mono(
                    color: AppColors.accentEmerald,
                    size: 10,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPeriodPill(ExperienceModel exp) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Text(
        exp.period,
        style: AppTypography.mono(size: 12, color: AppColors.accentCyan),
      ),
    );
  }
}
