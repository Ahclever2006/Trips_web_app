
import 'package:flutter/material.dart';

class DS {
  // Dark palette tuned to screenshot
  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF1C1C1C);
  static const Color cardStroke = Color(0x33222222);
  static const Color textPrimary = Color(0xFFF3F3F3);
  static const Color textSecondary = Color(0xFFB2B2B2);
  static const Color accent = Color(0xFFF5B82E); // gold
  static const Color border = Color(0xFF2A2A2A);

  static const Color statusPending = Color(0xFF7A4B2E);   // brownish
  static const Color statusProposal = Color(0xFF6B6B6B);  // gray
  static const Color statusReady = Color(0xFF3A7BD5);     // blue

  // Radii
  static const BorderRadius r8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius r12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius r16 = BorderRadius.all(Radius.circular(16));

  // Shadows (subtle)
  static const List<BoxShadow> shadowSm = [
    BoxShadow(color: Color(0x22000000), blurRadius: 12, offset: Offset(0, 6)),
  ];
}
