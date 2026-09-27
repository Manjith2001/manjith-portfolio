import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionReveal extends StatelessWidget {
  final Widget child;
  final int index;
  final Duration? delay;

  const SectionReveal({
    super.key,
    required this.child,
    this.index = 0,
    this.delay,
  });

  @override
  Widget build(BuildContext context) {
    // Support prefers-reduced-motion
    final mediaQuery = MediaQuery.maybeOf(context);
    final disableAnimations = mediaQuery?.disableAnimations ?? false;

    if (disableAnimations) {
      return child;
    }

    final isTest = WidgetsBinding.instance.runtimeType.toString().contains(
      'TestWidgetsFlutterBinding',
    );
    if (isTest) return child;

    // Staggered delay
    final effectiveDelay = delay ?? Duration(milliseconds: 100 * index);

    return child
        .animate(delay: effectiveDelay)
        .fadeIn(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuint,
        )
        .slideY(
          begin: 0.05,
          end: 0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuint,
        );
  }
}
