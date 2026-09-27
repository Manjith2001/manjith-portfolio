import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class TechChip extends StatefulWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final bool isSelected;
  final bool isHighlighted;
  final VoidCallback? onTap;

  const TechChip({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.isSelected = false,
    this.isHighlighted = false,
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

    final isSelected = widget.isSelected || widget.isHighlighted;

    final backgroundColor = isSelected
        ? effectiveColor
        : _isHovered && isInteractive
        ? AppColors.cardHover
        : Colors.white.withValues(alpha: 0.05); // Glass background

    final borderColor = isSelected
        ? effectiveColor
        : _isHovered && isInteractive
        ? effectiveColor.withValues(alpha: 0.5)
        : AppColors.borderLight.withValues(alpha: 0.5); // Subtle outline

    final textColor = isSelected
        ? Colors.white
        : _isHovered && isInteractive
        ? AppColors.textPrimary
        : AppColors.textSecondary;

    return MouseRegion(
      cursor: isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuart,
          height: 32, // Compact padding
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(100), // Full pill shape
            border: Border.all(color: borderColor, width: 1),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: effectiveColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 14,
                  color: isSelected ? Colors.white : effectiveColor,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                widget.label,
                style: AppTypography.tag(
                  color: textColor,
                  size: 12,
                  weight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
