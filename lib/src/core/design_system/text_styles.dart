import 'package:flutter/material.dart';
import 'design_tokens.dart';
import 'package:google_fonts/google_fonts.dart';

class DSText {
  static TextTheme textTheme = TextTheme(
    headlineLarge: GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: DS.textPrimary,
      letterSpacing: -0.03 * 32,
      height: 1.0,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w300,
      color: DS.textPrimary,
      letterSpacing: -0.03 * 18,
      height: 1.44,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w200,
      color: DS.textSecondary,
      letterSpacing: -0.03 * 18,
      height: 1.44,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: DS.textSecondary,
      letterSpacing: -0.03 * 14,
      height: 1.57,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: DS.textSecondary,
      letterSpacing: -0.03 * 12,
      height: 1.5,
    ),
  );
}
