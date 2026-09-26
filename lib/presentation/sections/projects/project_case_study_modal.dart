import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/brand_icons.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/url_helper.dart';
import '../../../models/project_model.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/project_video_player.dart';
import '../../widgets/tech_chip.dart';

class ProjectCaseStudyModal extends StatefulWidget {
  final NavigationController navController;

  const ProjectCaseStudyModal({super.key, required this.navController});

  @override
  State<ProjectCaseStudyModal> createState() => _ProjectCaseStudyModalState();
}

class _ProjectCaseStudyModalState extends State<ProjectCaseStudyModal> {
  bool _showVideo = true;

  @override
  void initState() {
    super.initState();
    final project = widget.navController.selectedProject;
    _showVideo = project?.hasVideo ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.navController.selectedProject;
    if (project == null) return const SizedBox.shrink();

    final isMobile = Responsive.isMobile(context);
    final hasScreenshots = project.screenshots.isNotEmpty;
    final hasVideo = project.hasVideo;
    final activeIndex = widget.navController.selectedScreenshotIndex.clamp(
      0,
      hasScreenshots ? project.screenshots.length - 1 : 0,
    );

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.88),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1040, maxHeight: 900),
          margin: EdgeInsets.all(isMobile ? 12 : 28),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: project.accentColor.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            children: [
              // Modal Header
              _buildHeader(context, project),
              const Divider(color: AppColors.border, height: 1),

              // Modal Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isMobile ? 18 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Media Mode Switcher (Video vs Screenshots)
                      if (hasVideo && hasScreenshots) ...[
                        Row(
                          children: [
                            _buildMediaTab(
                              title: 'Live Video Demo',
                              icon: Icons.play_circle_fill_rounded,
                              isSelected: _showVideo,
                              onTap: () => setState(() => _showVideo = true),
                              accentColor: project.accentColor,
                            ),
                            const SizedBox(width: 12),
                            _buildMediaTab(
                              title:
                                  'Feature Screenshots (${project.screenshots.length})',
                              icon: Icons.photo_library_rounded,
                              isSelected: !_showVideo,
                              onTap: () => setState(() => _showVideo = false),
                              accentColor: project.accentColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Active Media: Video Player or Screenshot Gallery
                      if (hasVideo && _showVideo) ...[
                        ProjectVideoPlayer(
                          videoAsset: project.videoAsset!,
                          accentColor: project.accentColor,
                          title: '${project.name} • Commercial App Walkthrough',
                        ),
                        const SizedBox(height: 32),
                      ] else if (hasScreenshots) ...[
                        _buildScreenshotGallery(context, project, activeIndex),
                        const SizedBox(height: 32),
                      ],

                      // Grid of Details
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildOverview(project),
                                const SizedBox(height: 24),
                                _buildRoleAndArchitecture(project),
                                const SizedBox(height: 24),
                                _buildFeatures(project),
                                const SizedBox(height: 24),
                                _buildIntegrationsAndTech(project),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildOverview(project),
                                      const SizedBox(height: 28),
                                      _buildFeatures(project),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildRoleAndArchitecture(project),
                                      const SizedBox(height: 24),
                                      _buildIntegrationsAndTech(project),
                                    ],
                                  ),
                                ),
                              ],
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

  Widget _buildMediaTab({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color accentColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withValues(alpha: 0.15)
              : AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? accentColor.withValues(alpha: 0.8)
                : AppColors.border,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? accentColor : AppColors.textMuted,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTypography.mono(
                size: 12,
                weight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProjectModel project) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: project.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    project.hasVideo
                        ? Icons.smart_display_rounded
                        : Icons.apps_rounded,
                    color: project.accentColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              project.name,
                              style: AppTypography.h2(
                                size: 22,
                                weight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (project.clientRegion != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              project.clientRegion!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '${project.category} • ${project.clientName ?? "Commercial Client"} • ${project.platforms.join(" & ")}',
                        style: AppTypography.bodySmall(
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // External Store Links & Close Button
          Row(
            children: [
              if (project.hasPlayStore) ...[
                CustomButton(
                  label: 'Play Store',
                  icon: BrandIcons.googlePlay,
                  variant: ButtonVariant.outline,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  onPressed: () => UrlHelper.openUrl(project.playStoreUrl!),
                ),
                const SizedBox(width: 8),
              ],
              if (project.hasAppStore) ...[
                CustomButton(
                  label: 'App Store',
                  icon: BrandIcons.apple,
                  variant: ButtonVariant.outline,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  onPressed: () => UrlHelper.openUrl(project.appStoreUrl!),
                ),
                const SizedBox(width: 8),
              ],
              IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
                tooltip: 'Close Modal',
                onPressed: () => widget.navController.closeProjectDetail(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotGallery(
    BuildContext context,
    ProjectModel project,
    int activeIndex,
  ) {
    final screenshots = project.screenshots;
    final activeImage = screenshots[activeIndex];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          // Active Large Image Frame
          SizedBox(
            height: 380,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (screenshots.length > 1)
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      size: 36,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () => widget.navController.previousScreenshot(),
                  ),
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.borderLight,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          activeImage,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
                if (screenshots.length > 1)
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                      size: 36,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () => widget.navController.nextScreenshot(),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Thumbnail Row
          if (screenshots.length > 1)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: screenshots.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final path = entry.value;
                  final isSelected = idx == activeIndex;

                  return GestureDetector(
                    onTap: () => widget.navController.openLightbox(idx),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? project.accentColor
                              : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.asset(path, fit: BoxFit.cover),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOverview(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project Overview',
          style: AppTypography.h3(size: 18, weight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Text(
          project.fullDescription,
          style: AppTypography.body(size: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildFeatures(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features & Production Highlights',
          style: AppTypography.h3(size: 18, weight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Column(
          children: project.features.map((feat) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: project.accentColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 12,
                      color: project.accentColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      feat,
                      style: AppTypography.body(
                        size: 13,
                        color: AppColors.textPrimary,
                      ),
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

  Widget _buildRoleAndArchitecture(ProjectModel project) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Engineering Role',
            style: AppTypography.mono(size: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          Text(
            project.role,
            style: AppTypography.body(size: 15, weight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          if (project.hasPayments) ...[
            Text(
              'Integrated Payment Gateways',
              style: AppTypography.mono(
                size: 11,
                color: AppColors.accentEmerald,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: project.paymentGateways.map((gw) {
                return TechChip(label: gw, color: AppColors.accentEmerald);
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
          if (project.hasMapIntegration) ...[
            Text(
              'Location & Maps',
              style: AppTypography.mono(size: 11, color: AppColors.accentAmber),
            ),
            const SizedBox(height: 6),
            const TechChip(
              label: 'Google Maps Platform SDK',
              color: AppColors.accentAmber,
            ),
            const SizedBox(height: 16),
          ],
          if (project.hasShorebirdOta) ...[
            Text(
              'Production Delivery',
              style: AppTypography.mono(
                size: 11,
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(height: 6),
            const TechChip(
              label: 'Shorebird OTA Instant Patches',
              color: AppColors.primaryLight,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIntegrationsAndTech(ProjectModel project) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technologies & Tools',
            style: AppTypography.mono(size: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.technologies
                .map((t) => TechChip(label: t))
                .toList(),
          ),
          const SizedBox(height: 16),
          Text(
            'SDKs & Integrations',
            style: AppTypography.mono(size: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.integrations
                .map((i) => TechChip(label: i, color: AppColors.accentCyan))
                .toList(),
          ),
        ],
      ),
    );
  }
}
