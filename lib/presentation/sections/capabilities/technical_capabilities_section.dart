import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/capabilities_data.dart';
import '../../../models/experience_model.dart';
import '../../widgets/section_header.dart';
import '../../widgets/tech_chip.dart';

class TechnicalCapabilitiesSection extends StatelessWidget {
  const TechnicalCapabilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (width >= 1100) {
      crossAxisCount = 3;
    } else if (width >= 700) {
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
            tag: 'Engineering Capabilities',
            title: 'Technical Depth & Architecture',
            subtitle:
                'Delivering end-to-end commercial solutions: from robust Clean Architecture and '
                '9+ international payment gateways to native device features, mathematical calculation engines, and OTA pipelines.',
          ),
          const SizedBox(height: 36),

          // Symmetrical Responsive Grid - 100% Equal Row Heights
          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = 20.0;
              final capabilities = CapabilitiesData.capabilities;

              // Chunk capabilities into symmetrical rows based on crossAxisCount
              final List<List<CapabilityModel>> rows = [];
              for (var i = 0; i < capabilities.length; i += crossAxisCount) {
                rows.add(capabilities.sublist(
                  i,
                  (i + crossAxisCount > capabilities.length)
                      ? capabilities.length
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
                              child: _CapabilityCard(capability: rows[r][c]),
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

class _CapabilityCard extends StatefulWidget {
  final CapabilityModel capability;

  const _CapabilityCard({required this.capability});

  @override
  State<_CapabilityCard> createState() => _CapabilityCardState();
}

class _CapabilityCardState extends State<_CapabilityCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cap = widget.capability;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        constraints: const BoxConstraints(minHeight: 320),
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
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
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
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon - Red-tinted rounded square badge
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(cap.icon, color: AppColors.primary, size: 24),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Subtitle Tag
                      SizedBox(
                        height: 18,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            cap.subtitle.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.mono(
                              color: AppColors.primary,
                              size: 11,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Title - dynamic height instead of fixed to avoid clipping
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            cap.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.h3(
                              size: 18,
                              color: _isHovered ? Colors.white : AppColors.textPrimary,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Description - dynamic height with proper wrapping
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 60),
                        child: Text(
                          cap.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.body(
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Tags - Pinned to bottom for symmetry
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 30),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: cap.tags.map((tag) {
                    return TechChip(
                      label: tag,
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
