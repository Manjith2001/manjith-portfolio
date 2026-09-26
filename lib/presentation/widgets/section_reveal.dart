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
    final isTest = WidgetsBinding.instance.runtimeType.toString().contains(
      'TestWidgetsFlutterBinding',
    );
    if (isTest) return child;

    final effectiveDelay = delay ?? Duration(milliseconds: 70 * index);

    return child
        .animate(delay: effectiveDelay)
        .fadeIn(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        )
        .slideY(
          begin: 0.035,
          end: 0.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        );
  }
}
