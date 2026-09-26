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
              top: 24,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: AppTypography.h3(
                          size: 18,
                          weight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Screen ${activeIndex + 1} of ${project.screenshots.length}',
                        style: AppTypography.mono(
                          size: 12,
                          color: AppColors.accentCyan,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => widget.navController.closeLightbox(),
                  ),
                ],
              ),
            ),

            // Main Image with Hero/InteractiveViewer
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                  maxHeight: 750,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 70,
                ),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 3.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(activeImage, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),

            // Left arrow
            if (project.screenshots.length > 1)
              Positioned(
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_left_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                  onPressed: () => widget.navController.previousScreenshot(),
                ),
              ),

            // Right arrow
            if (project.screenshots.length > 1)
              Positioned(
                right: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_right_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                  onPressed: () => widget.navController.nextScreenshot(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
