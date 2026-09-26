import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds — near-black charcoal base
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF101014);
  static const Color card = Color(0xFF151518);
  static const Color cardHover = Color(0xFF1C1C22);
  static const Color glassSurface = Color(0xCC101014);

  // Borders
  static const Color border = Color(0xFF222228);
  static const Color borderLight = Color(0xFF333338);
  static const Color borderSubtle = Color(0xFF1A1A20);

  // Brand & Accent Colors — Strong Red/Crimson system
  static const Color primary = Color(0xFFE63946); // Crimson Red
  static const Color primaryLight = Color(0xFFFF4D5A);
  static const Color primaryDark = Color(0xFFC41E2E);
  static const Color primaryGlow = Color(0x33E63946);

  static const Color accentCyan = Color(0xFFFF6B6B); // Warm red secondary
  static const Color accentCyanGlow = Color(0x26FF6B6B);

  static const Color accentEmerald = Color(
    0xFF10B981,
  ); // Success & Production Active (keep green for semantics)
  static const Color accentEmeraldGlow = Color(0x2610B981);

  static const Color accentAmber = Color(0xFFF59E0B); // Highlights / Stars
  static const Color accentPurple = Color(0xFFFF3B30); // Red accent variant

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF475569);

  // Gradients — Red system
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFE63946), Color(0xFFFF6B6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF151518), Color(0xFF101014)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient accentPillGradient = LinearGradient(
    colors: [Color(0x26E63946), Color(0x1AFF6B6B)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.35),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> cardHoverShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.18),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
}
