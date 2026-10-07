import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final bool isCenter;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: isCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Small floating pill with subtle primary glow
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  tag.toUpperCase(),
                  style: AppTypography.mono(
                    color: AppColors.primaryLight,
                    size: 11,
                    weight: FontWeight.w700,
                  ).copyWith(letterSpacing: 1.2),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        
        // Subtle decorative line below tag
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 24),
          height: 1,
          width: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),

        // Editorial Title
        _buildHighlightedTitle(isMobile),

        // Muted subtitle with generous letter-spacing
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              subtitle!,
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
              style: AppTypography.bodyLarge(
                color: AppColors.textMuted,
                size: isMobile ? 14 : 16,
              ).copyWith(letterSpacing: 0.5, height: 1.6),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHighlightedTitle(bool isMobile) {
    final words = title.split(' ');
    
    final baseStyle = isMobile
        ? AppTypography.display(size: 32, weight: FontWeight.w800)
        : AppTypography.display(size: 48, weight: FontWeight.w800);

    // Simple heuristic to highlight words after '&' or last word
    List<TextSpan> spans = [];
    bool highlightNext = false;

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final isLast = i == words.length - 1;
      final text = isLast ? word : '$word ';

      if (word == '&' || word.toLowerCase() == 'and') {
        spans.add(TextSpan(text: text, style: baseStyle));
        highlightNext = true;
      } else if (highlightNext || (i == words.length - 1 && words.length > 2 && !title.contains('&'))) {
        spans.add(TextSpan(
          text: text,
          style: baseStyle.copyWith(color: AppColors.primary),
        ));
        highlightNext = false;
      } else {
        spans.add(TextSpan(text: text, style: baseStyle));
      }
    }

    return Text.rich(
      TextSpan(children: spans),
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
    );
  }
}
