import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/clients_data.dart';
import '../../widgets/section_header.dart';
import '../../widgets/tech_chip.dart';

class WorkedClientsSection extends StatelessWidget {
  const WorkedClientsSection({super.key});

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
          // Section Header
          const SectionHeader(
            tag: 'Client Collaborations',
            title: 'Worked Clients & Commercial Brands',
            subtitle: 'Delivering scalable production mobile engineering for international clients across Qatar, Saudi Arabia, Kuwait, UAE, Singapore, Malaysia, and India.',
          ),
          const SizedBox(height: 36),

          // Structured Responsive Client Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = 20.0;
              final totalSpacing = spacing * (crossAxisCount - 1);
              final itemWidth =
                  (constraints.maxWidth - totalSpacing) / crossAxisCount;

              return Wrap(
                spacing: spacing,
                runSpacing: 20,
                children: ClientsData.clients.map((client) {
                  return SizedBox(
                    width: itemWidth,
                    child: _ClientCard(client: client),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ClientCard extends StatefulWidget {
  final ClientModel client;

  const _ClientCard({required this.client});

  @override
  State<_ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<_ClientCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final client = widget.client;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        constraints: const BoxConstraints(minHeight: 280),
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.02, 1.02, 1.0)
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // Red accent top border line
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
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Row: Icon + Symmetric Scale Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Red-tinted rounded square icon badge
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            client.icon,
                            color: AppColors.primary,
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(client.flag, style: const TextStyle(fontSize: 12)),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  client.scale,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.mono(
                                    size: 11,
                                    weight: FontWeight.w600,
                                    color: AppColors.accentEmerald,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Client Name - Symmetric Fixed Height Box
                  SizedBox(
                    height: 26,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        client.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.h3(
                          size: 18,
                          weight: FontWeight.w700,
                          color: _isHovered ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Domain & Region - Symmetric Fixed Height Box
                  SizedBox(
                    height: 20,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${client.domain} • ${client.region}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall(
                          size: 12,
                          color: AppColors.primaryLight,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Highlight Description - Symmetric Min Height Box
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 58),
                    child: Text(
                      client.highlight,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body(
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Uniform Technology Pills - Symmetric Box
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 32),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: client.technologies.take(3).map((tech) {
                        return TechChip(
                          label: tech,
                          color: _isHovered ? AppColors.primary : null,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
