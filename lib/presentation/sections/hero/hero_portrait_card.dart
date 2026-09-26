import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/personal_info.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/brand_icons.dart';

class HeroPortraitCard extends StatefulWidget {
  const HeroPortraitCard({super.key});

  @override
  State<HeroPortraitCard> createState() => _HeroPortraitCardState();
}

class _HeroPortraitCardState extends State<HeroPortraitCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  Offset _pointerOffset = Offset.zero;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    // Only repeat in live execution, not in headless automated widget tests
    final isTest = WidgetsBinding.instance.runtimeType.toString().contains(
      'TestWidgetsFlutterBinding',
    );
    if (!isTest) {
      _animController.repeat();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _pointerOffset = Offset.zero;
      }),
      onHover: (event) {
        final size = context.size;
        if (size != null && size.width > 0 && size.height > 0) {
          final x = (event.localPosition.dx / size.width - 0.5) * 2;
          final y = (event.localPosition.dy / size.height - 0.5) * 2;
          setState(() => _pointerOffset = Offset(x, y));
        }
      },
      child: AnimatedBuilder(
        animation: _animController,
        builder: (context, child) {
          final floatOffset = math.sin(_animController.value * 2 * math.pi) * 5;

          return Transform.translate(
            offset: Offset(0, floatOffset),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_pointerOffset.dx * 0.04)
                ..rotateX(-_pointerOffset.dy * 0.04),
              alignment: Alignment.center,
              child: child,
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Ambient Rotating Glow Backdrop
            Positioned(
              top: -15,
              right: -15,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(
                        alpha: _isHovered ? 0.35 : 0.22,
                      ),
                      AppColors.accentCyan.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Animated Gradient Border Ring (Cool Modern Aura)
            AnimatedBuilder(
              animation: _animController,
              builder: (context, _) {
                final angle = _animController.value * 2 * math.pi;
                return Container(
                  width: 326,
                  height: 426,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    gradient: SweepGradient(
                      transform: GradientRotation(angle),
                      colors: [
                        AppColors.primary.withValues(alpha: 0.8),
                        AppColors.accentCyan.withValues(alpha: 0.8),
                        AppColors.accentPurple.withValues(alpha: 0.8),
                        AppColors.accentEmerald.withValues(alpha: 0.8),
                        AppColors.primary.withValues(alpha: 0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: _isHovered ? 0.4 : 0.2,
                        ),
                        blurRadius: 28,
                        spreadRadius: _isHovered ? 2 : 0,
                      ),
                    ],
                  ),
                );
              },
            ),

            // Main Editorial Portrait Frame
            Container(
              width: 320,
              height: 420,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      PersonalInfo.profileImage,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, -0.4),
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.card,
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: AppColors.textMuted,
                            ),
                          ),
                        );
                      },
                    ),

                    // Subtle bottom gradient vignette
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.background.withValues(alpha: 0.2),
                              AppColors.background.withValues(alpha: 0.9),
                            ],
                            stops: const [0.4, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Clean Glassmorphic Status Pill at Bottom of Photo
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withValues(alpha: 0.88),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.borderLight.withValues(alpha: 0.7),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: AppColors.accentEmerald,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Flutter Mobile Lead',
                              style: AppTypography.mono(
                                size: 11,
                                color: Colors.white,
                                weight: FontWeight.w600,
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

            // Floating Top Badge: 17+ Production Apps
            Positioned(
              top: 20,
              left: -24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.45),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.rocket_launch_rounded,
                        size: 16,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '17+ Production Apps',
                          style: AppTypography.body(
                            size: 13,
                            weight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              BrandIcons.googlePlay,
                              size: 11,
                              color: AppColors.accentEmerald,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Play Store',
                              style: AppTypography.bodySmall(
                                size: 10,
                                color: AppColors.textMuted,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              BrandIcons.apple,
                              size: 12,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'App Store',
                              style: AppTypography.bodySmall(
                                size: 10,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Floating Bottom Badge: Shorebird OTA Deployed
            Positioned(
              bottom: 20,
              right: -24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.45),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.accentEmerald.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        size: 16,
                        color: AppColors.accentEmerald,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shorebird OTA Active',
                          style: AppTypography.body(
                            size: 13,
                            weight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Zero-Downtime Releases',
                          style: AppTypography.bodySmall(
                            size: 10,
                            color: AppColors.accentEmerald,
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
    );
  }
}
