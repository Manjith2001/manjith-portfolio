import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum ButtonVariant { primary, secondary, outline, ghost }

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool iconTrailing;
  final ButtonVariant variant;
  final double? width;
  final EdgeInsets? padding;
  final Color? customAccent;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconTrailing = false,
    this.variant = ButtonVariant.primary,
    this.width,
    this.padding,
    this.customAccent,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.customAccent ?? AppColors.primary;

    Color bg;
    Border? border;
    List<BoxShadow>? shadow;
    Color textColor;

    switch (widget.variant) {
      case ButtonVariant.primary:
        bg = _isHovered ? accent.withOpacity(0.9) : accent;
        border = Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        );
        shadow = [
          BoxShadow(
            color: accent.withValues(alpha: _isHovered ? 0.6 : 0.3),
            blurRadius: _isHovered ? 24 : 12,
            offset: Offset(0, _isHovered ? 6 : 4),
          ),
        ];
        textColor = Colors.white;
        break;

      case ButtonVariant.secondary:
        bg = _isHovered ? AppColors.cardHover : AppColors.card;
        border = Border.all(
          color: _isHovered ? AppColors.borderLight : AppColors.border,
          width: 1,
        );
        shadow = _isHovered ? AppColors.cardShadow : null;
        textColor = AppColors.textPrimary;
        break;

      case ButtonVariant.outline:
        bg = _isHovered ? accent.withValues(alpha: 0.1) : Colors.transparent;
        border = Border.all(
          color: _isHovered ? accent : AppColors.borderLight,
          width: 1.5,
        );
        textColor = _isHovered ? Colors.white : AppColors.textPrimary;
        break;

      case ButtonVariant.ghost:
        bg = _isHovered
            ? AppColors.cardHover.withValues(alpha: 0.5)
            : Colors.transparent;
        border = null;
        textColor = _isHovered ? Colors.white : AppColors.textSecondary;
        break;
    }

    final buttonContent = Row(
      mainAxisSize: widget.width != null ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null && !widget.iconTrailing) ...[
          Icon(widget.icon, size: 18, color: textColor),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            widget.label,
            style: AppTypography.button(
              color: textColor,
              size: 14,
              weight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (widget.icon != null && widget.iconTrailing) ...[
          const SizedBox(width: 8),
          Icon(widget.icon, size: 18, color: textColor),
        ],
      ],
    );

    return MouseRegion(
      cursor: widget.onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuart,
          width: widget.width,
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: widget.onPressed != null ? bg : bg.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(100), // Pill styling
            border: border,
            boxShadow: widget.onPressed != null ? shadow : null,
          ),
          child: buttonContent,
        ),
      ),
    );
  }
}
