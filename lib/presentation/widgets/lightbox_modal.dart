import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../controllers/navigation_controller.dart';

class LightboxModal extends StatefulWidget {
  final NavigationController navController;

  const LightboxModal({super.key, required this.navController});

  @override
  State<LightboxModal> createState() => _LightboxModalState();
}

class _LightboxModalState extends State<LightboxModal> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.navController.selectedProject;
    if (project == null || project.screenshots.isEmpty) {
      return const SizedBox.shrink();
    }

    final activeIndex = widget.navController.selectedScreenshotIndex.clamp(
      0,
      project.screenshots.length - 1,
    );
    final activeImage = project.screenshots[activeIndex];

    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            widget.navController.closeLightbox();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            widget.navController.nextScreenshot();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            widget.navController.previousScreenshot();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.95),
        body: Stack(
          alignment: Alignment.center,
          children: [
            // Close background touch
            GestureDetector(
              onTap: () => widget.navController.closeLightbox(),
              child: Container(color: Colors.transparent),
            ),

            // Top Header Bar
            Positioned(
              top: 32,
              left: 32,
              right: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: AppTypography.h2(
                          size: 24,
                          weight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'Screen ${activeIndex + 1} of ${project.screenshots.length}',
                          style: AppTypography.mono(
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white),
                      onPressed: () => widget.navController.closeLightbox(),
                    ),
                  ),
                ],
              ),
            ),

            // Main Image in Device Frame
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 400, // Phone max width
                  maxHeight: 850,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: AppColors.borderLight, width: 8),
                      boxShadow: [
                        BoxShadow(
                          color: project.accentColor.withValues(alpha: 0.2),
                          blurRadius: 60,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Stack(
                        children: [
                          Image.asset(activeImage, fit: BoxFit.cover),
                          // Notch
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 120,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
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
            ),

            // Floating Navigation Pods
            if (project.screenshots.length > 1)
              Positioned(
                left: 32,
                child: _buildNavPod(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => widget.navController.previousScreenshot(),
                ),
              ),

            if (project.screenshots.length > 1)
              Positioned(
                right: 32,
                child: _buildNavPod(
                  icon: Icons.chevron_right_rounded,
                  onTap: () => widget.navController.nextScreenshot(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavPod({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20), // Pod shape
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 32, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
