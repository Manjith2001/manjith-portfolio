import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isFeatured;
  final VoidCallback onSelect;

  const ProjectCard({
    super.key,
    required this.project,
    this.isFeatured = false,
    required this.onSelect,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onSelect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: _isHovered ? Matrix4.translationValues(0, -6, 0) : Matrix4.identity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Phone Device Frame (Symmetric, regular proportion)
              _buildDeviceFrame(project),
              const SizedBox(height: 16),
              // Metadata Below
              _buildMetadata(project),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceFrame(ProjectModel project) {
    final frameColor = _isHovered ? project.accentColor : AppColors.borderLight;

    return AspectRatio(
      aspectRatio: 9 / 18.5, // Standard modern handheld phone aspect ratio
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F14),
          borderRadius: BorderRadius.circular(32), // Phone bezel radius
          border: Border.all(
            color: frameColor.withValues(alpha: _isHovered ? 0.7 : 0.4),
            width: 2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: project.accentColor.withValues(alpha: 0.25),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0), // Bezel thickness
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(28), // Inner screen radius
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Screen Content: Screenshot OR Stylized App Mockup with Name
                if (project.hasScreenshots)
                  AnimatedScale(
                    scale: _isHovered ? 1.04 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    child: Image.asset(
                      project.thumbnail,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (_, _, _) => _buildAppScreenFallback(project),
                    ),
                  )
                else
                  _buildAppScreenFallback(project),

                // Device Hardware Details: Dynamic Island & Home Indicator
                _buildHardwareOverlay(),

                // Hover Gradient
                if (_isHovered)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.surface.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.35],
                      ),
                    ),
                  ),

                // Play Button overlay for video demos
                if (project.hasVideo && _isHovered)
                  Center(
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.5),
                            blurRadius: 16,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: const Icon(Icons.play_arrow_rounded, size: 32, color: Colors.white),
                    ).animate().scale(duration: 180.ms, curve: Curves.easeOutBack),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHardwareOverlay() {
    return IgnorePointer(
      child: Stack(
        children: [
          // Dynamic Island / Camera Notch
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              width: 76,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Home Indicator Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: 90,
              height: 3.5,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Rich App Screen Mockup showing project name, client region, and stylized UI
  Widget _buildAppScreenFallback(ProjectModel project) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF16161E),
            const Color(0xFF101017),
            project.accentColor.withValues(alpha: 0.15),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),

            // Simulated App Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Colors.white.withValues(alpha: 0.7)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: project.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    project.category.toUpperCase(),
                    style: AppTypography.mono(size: 8, color: project.accentColor, weight: FontWeight.w700),
                  ),
                ),
                Icon(Icons.more_horiz_rounded, size: 16, color: Colors.white.withValues(alpha: 0.7)),
              ],
            ),
            const SizedBox(height: 24),

            // App Brand Icon & Name on the Screen
            Center(
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: project.accentColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: project.accentColor.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: project.accentColor.withValues(alpha: 0.2),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        project.hasVideo
                            ? Icons.smart_display_rounded
                            : Icons.phone_android_rounded,
                        color: project.accentColor,
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    project.name,
                    textAlign: TextAlign.center,
                    style: AppTypography.h3(
                      size: 17,
                      weight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (project.clientRegion != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      project.clientRegion!,
                      style: AppTypography.bodySmall(
                        size: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Spacer(),

            // Stylized UI Cards simulating app dashboard
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: project.accentColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.bolt_rounded, size: 18, color: project.accentColor),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 6, width: 80, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(4))),
                        const SizedBox(height: 6),
                        Container(height: 4, width: 50, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 5, width: 60, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4))),
                  Container(height: 5, width: 30, decoration: BoxDecoration(color: project.accentColor.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(4))),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadata(ProjectModel project) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category and Video Tag
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: project.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: project.accentColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  project.category.toUpperCase(),
                  style: AppTypography.mono(
                    size: 9,
                    weight: FontWeight.w700,
                    color: project.accentColor,
                  ),
                ),
              ),
              const Spacer(),
              if (project.hasVideo)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.accentCyan.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.play_circle_fill_rounded, size: 11, color: AppColors.accentCyan),
                      const SizedBox(width: 4),
                      Text(
                        'DEMO',
                        style: AppTypography.mono(
                          size: 9,
                          weight: FontWeight.w700,
                          color: AppColors.accentCyan,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Project Name
          Text(
            project.name,
            style: AppTypography.h3(
              size: 17,
              weight: FontWeight.w700,
              color: _isHovered ? Colors.white : AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Technologies Pills (compact)
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.technologies.take(3).map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.7)),
                ),
                child: Text(
                  tech,
                  style: AppTypography.bodySmall(
                    size: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}