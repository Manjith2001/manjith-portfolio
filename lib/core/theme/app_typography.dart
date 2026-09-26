import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle display({Color color = AppColors.textPrimary, double size = 56, FontWeight weight = FontWeight.w800}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: -1.5,
      height: 1.1,
    );
  }

  static TextStyle h1({Color color = AppColors.textPrimary, double size = 40, FontWeight weight = FontWeight.w700}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: -1.0,
      height: 1.2,
    );
  }

  static TextStyle h2({Color color = AppColors.textPrimary, double size = 30, FontWeight weight = FontWeight.w700}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: -0.6,
      height: 1.25,
    );
  }

  static TextStyle h3({Color color = AppColors.textPrimary, double size = 22, FontWeight weight = FontWeight.w600}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: -0.3,
      height: 1.3,
    );
  }

  static TextStyle bodyLarge({Color color = AppColors.textSecondary, double size = 17, FontWeight weight = FontWeight.w400}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: -0.1,
      height: 1.6,
    );
  }

  static TextStyle body({Color color = AppColors.textSecondary, double size = 15, FontWeight weight = FontWeight.w400}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: 0,
      height: 1.55,
    );
  }

  static TextStyle bodySmall({Color color = AppColors.textMuted, double size = 13, FontWeight weight = FontWeight.w400}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: 0.1,
      height: 1.5,
    );
  }

  static TextStyle tag({Color color = AppColors.primaryLight, double size = 12, FontWeight weight = FontWeight.w600}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: 0.4,
    );
  }

  static TextStyle mono({Color color = AppColors.accentCyan, double size = 13, FontWeight weight = FontWeight.w500}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: 0.5,
    );
  }

  static TextStyle button({Color color = Colors.white, double size = 14, FontWeight weight = FontWeight.w600}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: 0.2,
    );
  }
}

