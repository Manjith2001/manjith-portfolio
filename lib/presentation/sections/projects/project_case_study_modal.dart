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
      backgroundColor: Colors.black.withValues(alpha: 0.95),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1040, maxHeight: 900),
          margin: EdgeInsets.all(isMobile ? 12 : 28),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(40), // Device-like tablet frame
            border: Border.all(
              color: AppColors.borderLight,
              width: 8, // Bezel
            ),
            boxShadow: [
              BoxShadow(
                color: project.accentColor.withValues(alpha: 0.2),
                blurRadius: 80,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32), // Inner border radius
            child: Column(
              children: [
                // Modal Header
                _buildHeader(context, project),
                const Divider(color: AppColors.borderLight, height: 1),

                // Modal Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isMobile ? 18 : 32),
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
                                title: 'Feature Screenshots (${project.screenshots.length})',
                                icon: Icons.photo_library_rounded,
                                isSelected: !_showVideo,
                                onTap: () => setState(() => _showVideo = false),
                                accentColor: project.accentColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Active Media: Video Player or Screenshot Gallery
                        if (hasVideo && _showVideo) ...[
                          Center(
                            child: ProjectVideoPlayer(
                              videoAsset: project.videoAsset!,
                              accentColor: project.accentColor,
                              title: '${project.name} • Commercial App Walkthrough',
                            ),
                          ),
                          const SizedBox(height: 40),
                        ] else if (hasScreenshots) ...[
                          _buildScreenshotGallery(context, project, activeIndex),
                          const SizedBox(height: 40),
                        ],

                        // Grid of Details
                        isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildOverview(project),
                                  const SizedBox(height: 32),
                                  _buildRoleAndArchitecture(project),
                                  const SizedBox(height: 32),
                                  _buildFeatures(project),
                                  const SizedBox(height: 32),
                                  _buildIntegrationsAndTech(project),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildOverview(project),
                                        const SizedBox(height: 40),
                                        _buildFeatures(project),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 48),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildRoleAndArchitecture(project),
                                        const SizedBox(height: 32),
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
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? accentColor : AppColors.card,
          borderRadius: BorderRadius.circular(100), // Pill shape
          border: Border.all(
            color: isSelected ? accentColor : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : AppColors.textMuted,
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
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: project.accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle, // Circular pod
                  ),
                  child: Icon(
                    project.hasVideo ? Icons.smart_display_rounded : Icons.apps_rounded,
                    color: project.accentColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              project.name,
                              style: AppTypography.h1(
                                size: 28,
                                weight: FontWeight.w800,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (project.clientRegion != null) ...[
                            const SizedBox(width: 12),
                            TechChip(
                              label: project.clientRegion!,
                              color: AppColors.textMuted,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${project.category} • ${project.clientName ?? "Commercial Client"} • ${project.platforms.join(" & ")}',
                        style: AppTypography.bodySmall(
                          size: 14,
                          color: AppColors.textSecondary,
                        ).copyWith(letterSpacing: 0.5),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  onPressed: () => UrlHelper.openUrl(project.playStoreUrl!),
                ),
                const SizedBox(width: 12),
              ],
              if (project.hasAppStore) ...[
                CustomButton(
                  label: 'App Store',
                  icon: BrandIcons.apple,
                  variant: ButtonVariant.outline,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  onPressed: () => UrlHelper.openUrl(project.appStoreUrl!),
                ),
                const SizedBox(width: 16),
              ],
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardHover,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary, size: 24),
                  tooltip: 'Close Modal',
                  onPressed: () => widget.navController.closeProjectDetail(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotGallery(BuildContext context, ProjectModel project, int activeIndex) {
    final screenshots = project.screenshots;
    final activeImage = screenshots[activeIndex];

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(32), // Pod
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          // Active Large Image Frame
          SizedBox(
            height: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (screenshots.length > 1)
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded, size: 40, color: AppColors.textPrimary),
                    onPressed: () => widget.navController.previousScreenshot(),
                  ),
                Expanded(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 240), // Phone ratio
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(32), // Device frame
                        border: Border.all(color: AppColors.borderLight, width: 6),
                        boxShadow: [
                          BoxShadow(
                            color: project.accentColor.withValues(alpha: 0.15),
                            blurRadius: 40,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              activeImage,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                            // Device Notch
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: 80,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (screenshots.length > 1)
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded, size: 40, color: AppColors.textPrimary),
                    onPressed: () => widget.navController.nextScreenshot(),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),

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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? project.accentColor : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(path, fit: BoxFit.cover, alignment: Alignment.topCenter),
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
          style: AppTypography.display(size: 24, weight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        Text(
          project.fullDescription,
          style: AppTypography.bodyLarge(color: AppColors.textSecondary, size: 16).copyWith(height: 1.6),
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
          style: AppTypography.display(size: 24, weight: FontWeight.w800),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: project.features.map((feat) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.cardHover,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.6)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(Icons.check_circle_rounded, size: 18, color: project.accentColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feat,
                        style: AppTypography.body(size: 14, color: AppColors.textPrimary).copyWith(height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRoleAndArchitecture(ProjectModel project) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ENGINEERING ROLE',
            style: AppTypography.mono(size: 12, color: AppColors.textMuted, weight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            project.role,
            style: AppTypography.body(size: 16, weight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          if (project.hasPayments) ...[
            Text(
              'PAYMENT GATEWAYS',
              style: AppTypography.mono(size: 12, color: AppColors.accentEmerald, weight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.paymentGateways.map((gw) {
                return TechChip(label: gw, color: AppColors.accentEmerald);
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
          if (project.hasMapIntegration) ...[
            Text(
              'LOCATION & MAPS',
              style: AppTypography.mono(size: 12, color: AppColors.accentAmber, weight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            const TechChip(label: 'Google Maps Platform SDK', color: AppColors.accentAmber),
            const SizedBox(height: 24),
          ],
          if (project.hasShorebirdOta) ...[
            Text(
              'PRODUCTION DELIVERY',
              style: AppTypography.mono(size: 12, color: AppColors.primaryLight, weight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            const TechChip(label: 'Shorebird OTA Instant Patches', color: AppColors.primaryLight),
          ],
        ],
      ),
    );
  }

  Widget _buildIntegrationsAndTech(ProjectModel project) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TECHNOLOGIES',
            style: AppTypography.mono(size: 12, color: AppColors.textMuted, weight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.technologies.map((t) => TechChip(label: t)).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'INTEGRATIONS',
            style: AppTypography.mono(size: 12, color: AppColors.textMuted, weight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.integrations.map((i) => TechChip(label: i, color: AppColors.accentCyan)).toList(),
          ),
        ],
      ),
    );
  }
}
