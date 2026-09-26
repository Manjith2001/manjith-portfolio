import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class TechChip extends StatefulWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final bool isSelected;
  final VoidCallback? onTap;

  const TechChip({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<TechChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? AppColors.primary;
    final isInteractive = widget.onTap != null;

    // Premium styling: deep indigo/violet electric glow on selection, no ordinary green
    final backgroundColor = widget.isSelected
        ? AppColors.primary.withValues(alpha: 0.25)
        : _isHovered && isInteractive
        ? AppColors.cardHover
        : const Color(0xFF111622);

    final borderColor = widget.isSelected
        ? AppColors.primaryLight.withValues(alpha: 0.85)
        : _isHovered && isInteractive
        ? effectiveColor.withValues(alpha: 0.55)
        : AppColors.border;

    final textColor = widget.isSelected
        ? Colors.white
        : _isHovered && isInteractive
        ? AppColors.textPrimary
        : AppColors.textSecondary;

    return MouseRegion(
      cursor: isInteractive
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: 30, // Uniform symmetric height for all pills
          padding: const EdgeInsets.symmetric(horizontal: 11),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor,
              width: widget.isSelected ? 1.2 : 1,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : (_isHovered && isInteractive
                    ? [
                        BoxShadow(
                          color: effectiveColor.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final textWidget = Text(
                widget.label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTypography.tag(
                  color: textColor,
                  size: 11.5,
                  weight: widget.isSelected
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              );

              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 13,
                      color: widget.isSelected
                          ? Colors.white
                          : (_isHovered ? effectiveColor : AppColors.textMuted),
                    ),
                    const SizedBox(width: 5),
                  ],
                  if (constraints.maxWidth.isFinite)
                    Flexible(child: textWidget)
                  else
                    textWidget,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
