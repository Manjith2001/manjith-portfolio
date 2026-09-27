import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/experience_data.dart';
import '../../../models/experience_model.dart';
import '../../widgets/section_header.dart';

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
          const SizedBox(height: 48),

          // Timeline Panels List
          Column(
            children: ExperienceData.experiences.map((exp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: _ExperienceTimelinePanel(experience: exp),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ExperienceTimelinePanel extends StatefulWidget {
  final ExperienceModel experience;

  const _ExperienceTimelinePanel({required this.experience});

  @override
  State<_ExperienceTimelinePanel> createState() =>
      _ExperienceTimelinePanelState();
}

class _ExperienceTimelinePanelState extends State<_ExperienceTimelinePanel> {
  bool _isHovered = false;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    // Default current role to show 4 items, others 3
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Vertical timeline line connecting to next item
          Positioned(
            top: 24,
            bottom: 0,
            left: 15,
            child: Container(
              width: 2,
              color: AppColors.borderLight.withValues(alpha: 0.5),
            ),
          ),
          // Timeline dot indicator
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: exp.isCurrent ? AppColors.surface : AppColors.card,
                shape: BoxShape.circle,
                border: Border.all(
                  color: exp.isCurrent ? AppColors.primary : AppColors.borderLight,
                  width: 2,
                ),
                boxShadow: exp.isCurrent
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: exp.isCurrent
                  ? Center(
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ),

          // Content Panel with left margin
          Padding(
            padding: EdgeInsets.only(left: isMobile ? 36 : 48),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.all(isMobile ? 0 : 20),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: _isHovered ? 0.4 : 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: exp.isCurrent
                      ? (_isHovered
                            ? AppColors.primary.withValues(alpha: 0.4)
                            : AppColors.primary.withValues(alpha: 0.15))
                      : AppColors.borderLight.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                    Text(
                      exp.highlightSummary!,
                      style: AppTypography.body(
                        size: 14,
                        color: exp.isCurrent
                            ? AppColors.primaryLight
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Responsibilities Bullet List
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: exp.responsibilities
                        .take(_isExpanded ? exp.responsibilities.length : 3)
                        .map((bullet) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
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
                                      size: 14,
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
                            size: 13,
                          ),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Technologies as Floating Pills
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: exp.keyTechnologies
                        .map((t) => _buildTechPill(t))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
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
            size: 22,
            weight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (exp.isCurrent) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentEmerald.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(100),
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
                const SizedBox(width: 6),
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
        color: AppColors.card,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.6)),
      ),
      child: Text(
        exp.period.toUpperCase(),
        style: AppTypography.mono(size: 11, color: AppColors.accentCyan, weight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTechPill(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.5)),
      ),
      child: Text(
        tech,
        style: AppTypography.bodySmall(
          size: 12,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}