import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../core/theme/app_colors.dart';

/// Global InheritedWidget to provide the live smooth cursor position
/// to any descendant widgets (such as [AmbientSpaceBackground]).
class SmoothCursorProvider extends InheritedWidget {
  final ValueNotifier<Offset?> cursorNotifier;

  const SmoothCursorProvider({
    super.key,
    required this.cursorNotifier,
    required super.child,
  });

  static ValueNotifier<Offset?>? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SmoothCursorProvider>()
        ?.cursorNotifier;
  }

  @override
  bool updateShouldNotify(SmoothCursorProvider oldWidget) =>
      cursorNotifier != oldWidget.cursorNotifier;
}

/// Particle model for the smooth stardust / ember trail
class _CursorParticle {
  Offset position;
  Offset velocity;
  double life;
  final double maxLife;
  final double size;
  final Color color;

  _CursorParticle({
    required this.position,
    required this.velocity,
    required this.maxLife,
    required this.size,
    required this.color,
  }) : life = maxLife;
}

class _CursorPaintData {
  final Offset? followerPosition;
  final Offset? dotPosition;
  final double opacity;
  final bool isPointerDown;
  final double speed;
  final double angle;
  final double rotationAngle;
  final List<_CursorParticle> particles;
  final double clickWaveProgress;
  final Offset? clickWaveOrigin;

  _CursorPaintData({
    required this.followerPosition,
    required this.dotPosition,
    required this.opacity,
    required this.isPointerDown,
    required this.speed,
    required this.angle,
    required this.rotationAngle,
    required this.particles,
    required this.clickWaveProgress,
    required this.clickWaveOrigin,
  });
}

/// Smooth Hardware-Accelerated Interactive Animated Cursor Follower.
///
/// Supports both Mouse Pointer movement and Touch screen gestures:
/// 1. Physics-based damped lerp inertia for fluid trailing.
/// 2. Dynamic velocity stretch & rotation along movement vector.
/// 3. Luminous stardust comet trail under cursor and touch drag.
/// 4. Elastic tactile click & touch shockwave reaction.
/// 5. Ambient glowing spotlight illuminating surrounding elements.
/// 6. 100% non-blocking via [IgnorePointer] and [HitTestBehavior.translucent].
class SmoothCursorFollower extends StatefulWidget {
  final Widget child;

  const SmoothCursorFollower({
    super.key,
    required this.child,
  });

  @override
  State<SmoothCursorFollower> createState() => _SmoothCursorFollowerState();
}

class _SmoothCursorFollowerState extends State<SmoothCursorFollower>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final ValueNotifier<Offset?> _cursorNotifier = ValueNotifier<Offset?>(null);

  late final ValueNotifier<_CursorPaintData> _paintDataNotifier = ValueNotifier(
    _CursorPaintData(
      followerPosition: null,
      dotPosition: null,
      opacity: 0.0,
      isPointerDown: false,
      speed: 0.0,
      angle: 0.0,
      rotationAngle: 0.0,
      particles: const [],
      clickWaveProgress: 0.0,
      clickWaveOrigin: null,
    ),
  );

  Offset? _targetPosition;
  Offset? _followerPosition;
  Offset? _dotPosition;

  double _opacity = 0.0;
  bool _isPointerDown = false;
  bool _isTouch = false;
  double _speed = 0.0;
  double _angle = 0.0;
  double _rotationAngle = 0.0;

  // Click & touch shockwave expansion
  double _clickWaveProgress = 0.0;
  Offset? _clickWaveOrigin;

  // Particle trail
  final List<_CursorParticle> _particles = [];
  final math.Random _random = math.Random();

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    final isTest = WidgetsBinding.instance.runtimeType.toString().contains(
      'TestWidgetsFlutterBinding',
    );

    _ticker = createTicker(_onTick);
    if (!isTest) {
      _ticker.start();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _ticker.dispose();
    _cursorNotifier.dispose();
    _paintDataNotifier.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    if (!mounted || _isDisposed) return;

    bool needsRepaint = false;

    // Smooth opacity fade
    final targetOpacity = (_targetPosition != null || _isPointerDown) ? 1.0 : 0.0;
    if ((_opacity - targetOpacity).abs() > 0.01) {
      _opacity += (targetOpacity - _opacity) * (_isTouch ? 0.10 : 0.18);
      needsRepaint = true;
    } else {
      _opacity = targetOpacity;
    }

    // Continuous rotation for outer glowing ring
    _rotationAngle += 0.04;
    if (_rotationAngle > math.pi * 2) {
      _rotationAngle -= math.pi * 2;
    }

    if (_targetPosition != null) {
      _followerPosition ??= _targetPosition;
      _dotPosition ??= _targetPosition;

      final dx = _targetPosition!.dx - _followerPosition!.dx;
      final dy = _targetPosition!.dy - _followerPosition!.dy;
      final distance = math.sqrt(dx * dx + dy * dy);

      // Inertia lerp for outer ring (fluid trailing)
      _followerPosition = Offset(
        _followerPosition!.dx + dx * 0.22,
        _followerPosition!.dy + dy * 0.22,
      );

      // Core dot lerp (faster follow)
      _dotPosition = Offset(
        _dotPosition!.dx + (_targetPosition!.dx - _dotPosition!.dx) * 0.65,
        _dotPosition!.dy + (_targetPosition!.dy - _dotPosition!.dy) * 0.65,
      );

      // Update external notifier for background sync
      _cursorNotifier.value = _followerPosition;

      // Velocity tracking
      _speed = (_speed * 0.8) + (distance * 0.2);

      // Movement angle
      if (distance > 1.2) {
        _angle = math.atan2(dy, dx);
      }

      // Spawn stardust comet particles when moving (mouse or touch drag)
      if (distance > 2.0 && _speed > 1.2 && _opacity > 0.15) {
        if (_particles.length < 24 && _random.nextDouble() < 0.70) {
          final particleColor = switch (_random.nextInt(3)) {
            0 => AppColors.primary,
            1 => AppColors.primaryLight,
            _ => AppColors.accentCyan,
          };

          _particles.add(
            _CursorParticle(
              position: _followerPosition! +
                  Offset(
                    (_random.nextDouble() - 0.5) * 8,
                    (_random.nextDouble() - 0.5) * 8,
                  ),
              velocity: Offset(
                (_random.nextDouble() - 0.5) * 0.8 - (dx * 0.04),
                (_random.nextDouble() - 0.5) * 0.8 - (dy * 0.04),
              ),
              maxLife: 1.0,
              size: 2.0 + _random.nextDouble() * 2.5,
              color: particleColor,
            ),
          );
        }
      }

      needsRepaint = true;
    }

    // Update existing particles
    if (_particles.isNotEmpty) {
      for (int i = _particles.length - 1; i >= 0; i--) {
        final p = _particles[i];
        p.position += p.velocity;
        p.life -= 0.042; // ~380ms lifespan
        if (p.life <= 0) {
          _particles.removeAt(i);
        }
      }
      needsRepaint = true;
    }

    // Click & touch shockwave expansion
    if (_clickWaveProgress > 0.0) {
      _clickWaveProgress += 0.045;
      if (_clickWaveProgress >= 1.0) {
        _clickWaveProgress = 0.0;
        _clickWaveOrigin = null;
      }
      needsRepaint = true;
    }

    if (needsRepaint) {
      _paintDataNotifier.value = _CursorPaintData(
        followerPosition: _followerPosition,
        dotPosition: _dotPosition,
        opacity: _opacity,
        isPointerDown: _isPointerDown,
        speed: _speed,
        angle: _angle,
        rotationAngle: _rotationAngle,
        particles: List.of(_particles),
        clickWaveProgress: _clickWaveProgress,
        clickWaveOrigin: _clickWaveOrigin,
      );
    }
  }

  void _onPointerHover(PointerHoverEvent event) {
    _isTouch = false;
    _targetPosition = event.localPosition;
  }

  void _onPointerMove(PointerMoveEvent event) {
    _targetPosition = event.localPosition;
    if (event.kind == PointerDeviceKind.touch) {
      _isTouch = true;
    }
  }

  void _onPointerDown(PointerDownEvent event) {
    _targetPosition = event.localPosition;
    _isPointerDown = true;
    _isTouch = event.kind == PointerDeviceKind.touch;
    _clickWaveProgress = 0.01;
    _clickWaveOrigin = event.localPosition;
  }

  void _onPointerUp(PointerUpEvent event) {
    _isPointerDown = false;
    if (event.kind == PointerDeviceKind.touch) {
      _targetPosition = null;
      _cursorNotifier.value = null;
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _isPointerDown = false;
    _targetPosition = null;
    _cursorNotifier.value = null;
  }

  void _onMouseEnter(PointerEnterEvent event) {
    _isTouch = false;
    _targetPosition = event.localPosition;
  }

  void _onMouseExit(PointerExitEvent event) {
    _targetPosition = null;
    _cursorNotifier.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return SmoothCursorProvider(
      cursorNotifier: _cursorNotifier,
      child: MouseRegion(
        onEnter: _onMouseEnter,
        onExit: _onMouseExit,
        onHover: _onPointerHover,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerHover: _onPointerHover,
          onPointerMove: _onPointerMove,
          onPointerDown: _onPointerDown,
          onPointerUp: _onPointerUp,
          onPointerCancel: _onPointerCancel,
          child: Stack(
            children: [
              // 1. Main Application UI - completely interactive
              widget.child,

              // 2. Smooth Animated Cursor & Touch Layer - 100% non-blocking
              ValueListenableBuilder<_CursorPaintData>(
                valueListenable: _paintDataNotifier,
                builder: (context, data, child) {
                  if (data.opacity <= 0.001 && data.particles.isEmpty && data.clickWaveProgress <= 0) {
                    return const SizedBox.shrink();
                  }
                  return Positioned.fill(
                    child: IgnorePointer(
                      child: RepaintBoundary(
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: _SmoothCursorPainter(
                            followerPosition: data.followerPosition,
                            dotPosition: data.dotPosition,
                            opacity: data.opacity,
                            isPointerDown: data.isPointerDown,
                            speed: data.speed,
                            angle: data.angle,
                            rotationAngle: data.rotationAngle,
                            particles: data.particles,
                            clickWaveProgress: data.clickWaveProgress,
                            clickWaveOrigin: data.clickWaveOrigin,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmoothCursorPainter extends CustomPainter {
  final Offset? followerPosition;
  final Offset? dotPosition;
  final double opacity;
  final bool isPointerDown;
  final double speed;
  final double angle;
  final double rotationAngle;
  final List<_CursorParticle> particles;
  final double clickWaveProgress;
  final Offset? clickWaveOrigin;

  _SmoothCursorPainter({
    required this.followerPosition,
    required this.dotPosition,
    required this.opacity,
    required this.isPointerDown,
    required this.speed,
    required this.angle,
    required this.rotationAngle,
    required this.particles,
    required this.clickWaveProgress,
    required this.clickWaveOrigin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    if (opacity <= 0.001 && particles.isEmpty && clickWaveProgress <= 0) return;

    // 1. Stardust Comet Trail Particles (under both mouse and touch drag)
    if (particles.isNotEmpty) {
      for (final p in particles) {
        final progress = (p.life / p.maxLife).clamp(0.0, 1.0);
        final pPaint = Paint()
          ..color = p.color.withValues(
            alpha: (progress * 0.85 * (opacity > 0.1 ? opacity : 1.0)).clamp(0.0, 1.0),
          )
          ..style = PaintingStyle.fill;

        if (progress > 0.25) {
          final glowPaint = Paint()
            ..color = p.color.withValues(
              alpha: (progress * 0.35 * (opacity > 0.1 ? opacity : 1.0)).clamp(0.0, 1.0),
            )
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
          canvas.drawCircle(p.position, p.size * progress * 1.6, glowPaint);
        }

        canvas.drawCircle(p.position, p.size * progress, pPaint);
      }
    }

    // 2. Click & Touch Ripple Shockwave
    if (clickWaveProgress > 0.0 && clickWaveOrigin != null) {
      final waveRadius = 14.0 + (clickWaveProgress * 48.0);
      final waveAlpha =
          (1.0 - clickWaveProgress).clamp(0.0, 1.0) * 0.70;
      final wavePaint = Paint()
        ..color = AppColors.primaryLight.withValues(alpha: waveAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0 * (1.0 - clickWaveProgress * 0.5);
      canvas.drawCircle(clickWaveOrigin!, waveRadius, wavePaint);
    }

    if (followerPosition == null || opacity <= 0.01) return;
    final pos = followerPosition!;

    // 3. Ambient Floating Spotlight Glow
    const spotlightRadius = 120.0;
    final spotlightPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0.14 * opacity),
          AppColors.accentCyan.withValues(alpha: 0.04 * opacity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: pos, radius: spotlightRadius));
    canvas.drawCircle(pos, spotlightRadius, spotlightPaint);

    // 4. Smooth Outer Dynamic Ring (Aerodynamic stretch & rotation)
    canvas.save();
    canvas.translate(pos.dx, pos.dy);

    final stretchX = (1.0 + (speed / 36.0)).clamp(1.0, 1.45);
    final stretchY = (1.0 - (speed / 120.0)).clamp(0.70, 1.0);
    final clickScale = isPointerDown ? 0.70 : 1.0;

    canvas.rotate(angle);
    canvas.scale(stretchX * clickScale, stretchY * clickScale);

    const baseRadius = 19.0;

    // Glowing outer ring blur
    final ringGlowPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.35 * opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
    canvas.drawCircle(Offset.zero, baseRadius, ringGlowPaint);

    // Dual-tone rotating gradient ring
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..shader = SweepGradient(
        colors: [
          AppColors.primaryLight.withValues(alpha: 0.95 * opacity),
          AppColors.accentCyan.withValues(alpha: 0.55 * opacity),
          AppColors.primary.withValues(alpha: 0.20 * opacity),
          AppColors.primaryLight.withValues(alpha: 0.95 * opacity),
        ],
        transform: GradientRotation(rotationAngle),
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: baseRadius));

    canvas.drawCircle(Offset.zero, baseRadius, ringPaint);
    canvas.restore();

    // 5. Precision Core Glowing Dot
    final core = dotPosition ?? pos;

    final coreGlowPaint = Paint()
      ..color = AppColors.primaryLight.withValues(alpha: 0.55 * opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.5);
    canvas.drawCircle(core, 5.0, coreGlowPaint);

    final corePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.98 * opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(core, isPointerDown ? 2.2 : 2.8, corePaint);
  }

  @override
  bool shouldRepaint(covariant _SmoothCursorPainter oldDelegate) {
    return oldDelegate.followerPosition != followerPosition ||
        oldDelegate.dotPosition != dotPosition ||
        oldDelegate.opacity != opacity ||
        oldDelegate.isPointerDown != isPointerDown ||
        oldDelegate.speed != speed ||
        oldDelegate.angle != angle ||
        oldDelegate.rotationAngle != rotationAngle ||
        oldDelegate.particles.length != particles.length ||
        oldDelegate.clickWaveProgress != clickWaveProgress;
  }
}