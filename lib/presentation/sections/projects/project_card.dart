import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/brand_icons.dart';
import '../../../core/utils/url_helper.dart';
import '../../../models/project_model.dart';
import '../../widgets/tech_chip.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback onSelect;

  const ProjectCard({super.key, required this.project, required this.onSelect});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final hasImage = project.hasScreenshots;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onSelect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          constraints: const BoxConstraints(minHeight: 490),
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -4.0, 0.0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.cardHover : AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.border,
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.22),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
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
                  // Top Media Header with rounded top corners
                  if (hasImage)
                    _buildScreenshotPreview(project)
                  else
                    _buildBrandedHeader(project),

                  // Red accent divider line
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: _isHovered ? 0.8 : 0.4),
                          AppColors.primaryLight.withValues(alpha: _isHovered ? 0.5 : 0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  // Content Body with Symmetric Sections
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Category & Platform badges - Responsive Wrap
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            Container(
                              height: 26,
                              constraints: const BoxConstraints(maxWidth: 220),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                project.category.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.mono(
                                  color: AppColors.primary,
                                  size: 10.5,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),

                            // Store / Platform indicators & Video Demo badge
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (project.hasPlayStore)
                                  IconButton(
                                    icon: const Icon(
                                      BrandIcons.googlePlay,
                                      size: 15,
                                    ),
                                    color: AppColors.primaryLight,
                                    tooltip: 'Open on Google Play Store',
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    onPressed: () =>
                                        UrlHelper.openUrl(project.playStoreUrl!),
                                  ),
                                if (project.hasAppStore)
                                  IconButton(
                                    icon: const Icon(BrandIcons.apple, size: 16),
                                    color: AppColors.textPrimary,
                                    tooltip: 'Open on Apple App Store',
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    onPressed: () =>
                                        UrlHelper.openUrl(project.appStoreUrl!),
                                  ),
                                if (project.hasVideo)
                                  Container(
                                    height: 24,
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.16),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: AppColors.primary.withValues(alpha: 0.45),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.play_circle_fill_rounded,
                                          size: 12,
                                          color: AppColors.primaryLight,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Video Demo',
                                          style: AppTypography.mono(
                                            size: 10,
                                            weight: FontWeight.w600,
                                            color: AppColors.primaryLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Project Title & Client Region - Symmetric 28px height row
                        SizedBox(
                          height: 28,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  project.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.h3(
                                    size: 18,
                                    color: _isHovered
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (project.clientRegion != null) ...[
                                const SizedBox(width: 8),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 110),
                                  child: Text(
                                    project.clientRegion!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Client Name - Symmetric 20px height row
                        SizedBox(
                          height: 20,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              project.clientName != null
                                  ? 'Client: ${project.clientName}'
                                  : 'Commercial Production',
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
                        const SizedBox(height: 8),

                        // Description - Symmetric 56px height block
                        SizedBox(
                          height: 56,
                          child: Text(
                            project.shortDescription,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.body(
                              size: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Specialized Feature Highlights (Payments, Maps, OTA) - Responsive row
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 26),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              if (project.hasPayments)
                                Container(
                                  height: 24,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.accentCyan.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: AppColors.accentCyan.withValues(alpha: 0.35),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.payment_rounded,
                                        size: 12,
                                        color: AppColors.accentCyan,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          project.paymentGateways.first,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTypography.mono(
                                            size: 10,
                                            color: AppColors.accentCyan,
                                            weight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (project.hasMapIntegration)
                                Container(
                                  height: 24,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.accentAmber.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: AppColors.accentAmber.withValues(alpha: 0.35),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.map_rounded,
                                        size: 12,
                                        color: AppColors.accentAmber,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          'Google Maps SDK',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTypography.mono(
                                            size: 10,
                                            color: AppColors.accentAmber,
                                            weight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (project.hasShorebirdOta)
                                Container(
                                  height: 24,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: AppColors.primaryLight.withValues(alpha: 0.35),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.bolt_rounded,
                                        size: 12,
                                        color: AppColors.primaryLight,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          'Shorebird OTA',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTypography.mono(
                                            size: 10,
                                            color: AppColors.primaryLight,
                                            weight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Standard Tech Chips - Responsive row
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 30),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: project.technologies.take(3).map((tech) {
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

              // Bottom Link Row - Pinned to bottom of the card for symmetry
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
                child: SizedBox(
                  height: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          project.hasVideo
                              ? 'Demo & Case Study'
                              : 'View Case Study',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.button(
                            color: _isHovered
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            size: 13,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        transform: Matrix4.translationValues(
                          _isHovered ? 4 : 0,
                          0,
                          0,
                        ),
                        child: Icon(
                          project.hasVideo
                              ? Icons.play_arrow_rounded
                              : Icons.arrow_forward_rounded,
                          size: 18,
                          color: _isHovered
                              ? AppColors.primary
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenshotPreview(ProjectModel project) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Screenshot image with subtle zoom
            AnimatedScale(
              scale: _isHovered ? 1.05 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: Image.asset(
                project.thumbnail,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFallbackImage(project),
              ),
            ),

            // Subtle gradient overlay for contrast
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.card.withValues(alpha: 0.1),
                      AppColors.card.withValues(alpha: 0.9),
                    ],
                    stops: const [0.4, 0.7, 1.0],
                  ),
                ),
              ),
            ),

            // Play button overlay for videos
            if (project.hasVideo)
              Center(
                child: AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.85,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandedHeader(ProjectModel project) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary.withValues(alpha: 0.15), AppColors.card],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            project.hasVideo
                ? Icons.smart_display_rounded
                : Icons.phone_android_rounded,
            size: 64,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          if (project.hasVideo)
            Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFallbackImage(ProjectModel project) {
    return Container(
      color: AppColors.surface,
      child: const Center(
        child: Icon(
          Icons.broken_image_rounded,
          color: AppColors.textMuted,
          size: 36,
        ),
      ),
    );
  }
}
