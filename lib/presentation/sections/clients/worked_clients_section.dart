import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/clients_data.dart';
import '../../widgets/section_header.dart';

class WorkedClientsSection extends StatelessWidget {
  const WorkedClientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Responsive.isTest
              ? const SectionHeader(
                  tag: 'Client Ecosystem',
                  title: 'Worked Clients & Commercial Brands',
                  subtitle:
                      'Delivering scalable production mobile engineering for international clients across '
                      'Qatar, Saudi Arabia, Kuwait, UAE, Singapore, Malaysia, and India.',
                )
              : const SectionHeader(
                  tag: 'Client Ecosystem',
                  title: 'Worked Clients & Commercial Brands',
                  subtitle:
                      'Delivering scalable production mobile engineering for international clients across '
                      'Qatar, Saudi Arabia, Kuwait, UAE, Singapore, Malaysia, and India.',
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 48),

          LayoutBuilder(
            builder: (context, constraints) {
              if (width >= 1024) {
                return _buildGrid(columns: 3, maxWidth: constraints.maxWidth);
              } else if (width >= 700) {
                return _buildGrid(columns: 2, maxWidth: constraints.maxWidth);
              } else {
                return _buildGrid(columns: 1, maxWidth: constraints.maxWidth);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGrid({required int columns, required double maxWidth}) {
    final double spacing = 24.0;
    final double totalSpacing = spacing * (columns - 1);
    final double itemWidth = (maxWidth - totalSpacing) / columns;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: ClientsData.clients.asMap().entries.map((entry) {
        final index = entry.key;
        final client = entry.value;

        final pod = _ClientPodCard(client: client);
        return SizedBox(
          width: itemWidth,
          child: Responsive.isTest
              ? pod
              : pod
                  .animate()
                  .fadeIn(delay: (60 * index).ms)
                  .slideY(begin: 0.08, end: 0),
        );
      }).toList(),
    );
  }
}

class _ClientPodCard extends StatefulWidget {
  final ClientModel client;

  const _ClientPodCard({required this.client});

  @override
  State<_ClientPodCard> createState() => _ClientPodCardState();
}

class _ClientPodCardState extends State<_ClientPodCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final client = widget.client;

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _isHovered ? Matrix4.translationValues(0, -4, 0) : Matrix4.identity(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.cardHover : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? client.accentColor.withValues(alpha: 0.5)
                : AppColors.borderLight.withValues(alpha: 0.7),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: client.accentColor.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surface,
              _isHovered
                  ? client.accentColor.withValues(alpha: 0.06)
                  : Colors.transparent,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Header: Icon + Name + Region Flag
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: client.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: client.accentColor.withValues(alpha: 0.25),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      client.icon,
                      color: client.accentColor,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.name,
                        style: AppTypography.h3(
                          size: 17,
                          weight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            client.flag,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              client.region,
                              style: AppTypography.mono(
                                size: 11,
                                color: AppColors.textMuted,
                              ),
                              maxLines: 1,
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
            const SizedBox(height: 14),

            // Domain Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: client.accentColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: client.accentColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Text(
                client.domain,
                style: AppTypography.mono(
                  size: 11,
                  weight: FontWeight.w600,
                  color: client.accentColor,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Highlight Summary
            Text(
              client.highlight,
              style: AppTypography.bodySmall(
                color: AppColors.textSecondary,
                size: 13,
              ).copyWith(height: 1.5),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Technologies Pills
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: client.technologies.take(3).map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColors.borderLight.withValues(alpha: 0.6),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tech,
                    style: AppTypography.bodySmall(
                      size: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
  }
}