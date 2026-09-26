import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AmbientSpaceBackground extends StatefulWidget {
  final ScrollController? scrollController;
  final Widget? child;

  const AmbientSpaceBackground({
    super.key,
    this.scrollController,
    this.child,
  });

  @override
  State<AmbientSpaceBackground> createState() => _AmbientSpaceBackgroundState();
}

class _AmbientSpaceBackgroundState extends State<AmbientSpaceBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Offset? _cursorPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    );

    // Only repeat indefinitely when not running in headless automated widget tests
    final isTest = WidgetsBinding.instance.runtimeType.toString().contains(
      'TestWidgetsFlutterBinding',
    );
    if (!isTest) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (event) {
        setState(() => _cursorPosition = event.localPosition);
      },
      onPointerMove: (event) {
        setState(() => _cursorPosition = event.localPosition);
      },
      onPointerDown: (event) {
        setState(() => _cursorPosition = event.localPosition);
      },
      child: Stack(
        children: [
          // 1. Solid deep charcoal foundation
          Container(color: const Color(0xFF0A0A0F)),

          // 2. Parallax Wallpaper Layer
          Positioned.fill(
            child: AnimatedBuilder(
              animation: widget.scrollController ?? _controller,
              builder: (context, _) {
                double scrollOffset = 0.0;
                if (widget.scrollController != null &&
                    widget.scrollController!.hasClients) {
                  scrollOffset = widget.scrollController!.offset;
                }

                // Parallax shift factor: moves at 12% of scroll speed
                final parallaxOffset = -(scrollOffset * 0.12).clamp(
                  -600.0,
                  0.0,
                );

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final targetHeight = constraints.maxHeight + 400.0;
                    return Transform.translate(
                      offset: Offset(0, parallaxOffset),
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: targetHeight,
                        child: Image.asset(
                          'assets/images/portfolio_bg.jpg',
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // 3. Dark overlay scrim for text contrast
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0A0A0F).withValues(alpha: 0.65),
                    const Color(0xFF0A0A0F).withValues(alpha: 0.78),
                    const Color(0xFF0A0A0F).withValues(alpha: 0.92),
                  ],
                  stops: const [0.0, 0.50, 1.0],
                ),
              ),
            ),
          ),

          // 4. Subtle Radial Vignette around screen edges
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.25,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF0A0A0F).withValues(alpha: 0.55),
                  ],
                  stops: const [0.55, 1.0],
                ),
              ),
            ),
          ),

          // 5. GPU-cached animated red aura, hex grid & cursor illumination
          Positioned.fill(
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: _RedHexAuraPainter(
                      progress: _controller.value,
                      cursorPosition: _cursorPosition,
                    ),
                  );
                },
              ),
            ),
          ),

          // 6. Child content
          if (widget.child != null) widget.child!,
        ],
      ),
    );
  }
}

class _RedHexAuraPainter extends CustomPainter {
  final double progress;
  final Offset? cursorPosition;

  _RedHexAuraPainter({required this.progress, this.cursorPosition});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final width = size.width;
    final height = size.height;
    final angle = progress * 2 * math.pi;

    // 1. Drifting Ambient Glow 1: Crimson Red (Top-Right drifting)
    final orb1Center = Offset(
      width * 0.82 + math.sin(angle) * 60,
      height * 0.18 + math.cos(angle) * 45,
    );
    final orb1Radius = width * 0.35;
    final orb1Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0.18),
          AppColors.primary.withValues(alpha: 0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: orb1Center, radius: orb1Radius));
    canvas.drawCircle(orb1Center, orb1Radius, orb1Paint);

    // 2. Drifting Ambient Glow 2: Warm Red (Bottom-Left drifting)
    final orb2Center = Offset(
      width * 0.12 + math.cos(angle * 0.8) * 55,
      height * 0.45 + math.sin(angle * 0.8) * 60,
    );
    final orb2Radius = width * 0.30;
    final orb2Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.accentCyan.withValues(alpha: 0.14),
          AppColors.accentCyan.withValues(alpha: 0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: orb2Center, radius: orb2Radius));
    canvas.drawCircle(orb2Center, orb2Radius, orb2Paint);

    // 3. Interactive Touch / Cursor Spotlight Illumination
    if (cursorPosition != null) {
      const spotlightRadius = 260.0;
      final spotlightPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.accentCyan.withValues(alpha: 0.04),
            Colors.transparent,
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(
          Rect.fromCircle(center: cursorPosition!, radius: spotlightRadius),
        );
      canvas.drawCircle(cursorPosition!, spotlightRadius, spotlightPaint);
    }

    // 4. Subtle Hexagonal Grid Pattern (red-tinted)
    _drawHexGrid(canvas, size, angle);

    // 5. Subtle Ambient Particle / Dot Matrix Accent
    final dotPaint = Paint()
      ..color = const Color(0xFF64748B).withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;

    const spacing = 46.0;
    final cols = (width / spacing).ceil();
    final rows = (height / spacing).ceil();

    for (int i = 0; i <= cols; i++) {
      for (int j = 0; j <= rows; j++) {
        final wave = math.sin((i * 0.3) + (j * 0.3) + angle);
        if (wave > 0.55) {
          canvas.drawCircle(Offset(i * spacing, j * spacing), 0.85, dotPaint);
        }
      }
    }
  }

  void _drawHexGrid(Canvas canvas, Size size, double angle) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const hexSize = 40.0;
    final hexHeight = hexSize * math.sqrt(3);
    final cols = (size.width / (hexSize * 1.5)).ceil() + 1;
    final rows = (size.height / hexHeight).ceil() + 1;

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        final x = col * hexSize * 1.5;
        final y = row * hexHeight + (col.isOdd ? hexHeight / 2 : 0);

        // Only draw some hexagons based on wave for visual interest
        final wave = math.sin((col * 0.4) + (row * 0.4) + angle * 0.5);
        if (wave > 0.1) {
          final opacity = ((wave - 0.1) * 0.06).clamp(0.0, 0.06);
          paint.color = AppColors.primary.withValues(alpha: opacity);
          _drawHexagon(canvas, Offset(x, y), hexSize * 0.5, paint);
        }
      }
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - math.pi / 6;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RedHexAuraPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.cursorPosition != cursorPosition;
  }
}
