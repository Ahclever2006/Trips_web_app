import 'package:flutter/material.dart';

class DS {
  // Dark palette tuned to screenshot
  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF1C1C1C);
  static const Color cardStroke = Color(0x33222222);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF999999);
  static const Color accent = Color(0xFFFFC268);
  static const Color border = Color(0xFF2A2A2A);

  static const Color statusPending = Color(0xFFC25F30);
  static const Color statusProposal = Color(0xFFFFC268);
  static const Color statusReady = Color(0xFF33BFED);

  // Radii
  static const BorderRadius r8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius r12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius r16 = BorderRadius.all(Radius.circular(16));

  // Shadows (subtle)
  static const List<BoxShadow> shadowSm = [
    BoxShadow(color: Color(0x22000000), blurRadius: 12, offset: Offset(0, 6)),
  ];

  static const Gradient tripCardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xFF171717)],
    stops: [0.10, 0.55],
  );
}
