import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/skills_data.dart';
import '../../../models/experience_model.dart';
import '../../widgets/section_header.dart';
import '../../widgets/tech_chip.dart';

class SkillsMatrixSection extends StatelessWidget {
  const SkillsMatrixSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (width >= 1100) {
      crossAxisCount = 3;
    } else if (width >= 720) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header without machine-generated slashes
          const SectionHeader(
            tag: 'Technical Skills',
            title: 'Verified Skills & Tech Ecosystem',
            subtitle:
                'Hands-on engineering competencies grouped across mobile platforms, state architectures, '
                'payment gateways, and production cloud services. Zero subjective percentages.',
          ),
          const SizedBox(height: 36),

          // Cards Grid - 100% Symmetric Row Heights
          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = 20.0;
              final categories = SkillsData.categories;

              // Chunk categories into symmetrical rows based on crossAxisCount
              final List<List<SkillCategoryModel>> rows = [];
              for (var i = 0; i < categories.length; i += crossAxisCount) {
                rows.add(categories.sublist(
                  i,
                  (i + crossAxisCount > categories.length)
                      ? categories.length
                      : i + crossAxisCount,
                ));
              }

              return Column(
                children: [
                  for (int r = 0; r < rows.length; r++) ...[
                    if (r > 0) const SizedBox(height: 20),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (int c = 0; c < rows[r].length; c++) ...[
                            if (c > 0) SizedBox(width: spacing),
                            Expanded(
                              child: _SkillCategoryCard(category: rows[r][c]),
                            ),
                          ],
                          // Fill remaining slots in last row to maintain symmetry
                          for (int k = 0; k < crossAxisCount - rows[r].length; k++) ...[
                            SizedBox(width: spacing),
                            const Expanded(child: SizedBox.shrink()),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategoryModel category;

  const _SkillCategoryCard({required this.category});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cat = widget.category;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        constraints: const BoxConstraints(minHeight: 180),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.cardHover : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.border,
            width: 1.2,
          ),
          boxShadow: _isHovered
              ? AppColors.cardHoverShadow
              : AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Red accent top border
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: _isHovered ? 1.0 : 0.6),
                        AppColors.primaryLight.withValues(alpha: _isHovered ? 0.8 : 0.3),
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
                  child: SizedBox(
                    height: 44,
                    child: Row(
                      children: [
                        // Red-tinted icon badge
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(cat.icon, color: AppColors.primary, size: 20),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            cat.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.body(
                              size: 15,
                              weight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Skills Chips - Pinned to bottom for symmetry
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 88),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: cat.skills.map((skill) {
                    return TechChip(
                      label: skill,
                      color: _isHovered ? AppColors.primary : null,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
