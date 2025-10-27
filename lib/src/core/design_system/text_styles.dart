
import 'package:flutter/material.dart';
import 'design_tokens.dart';

class DSText {
  static TextTheme textTheme = TextTheme(
    headlineLarge:   TextStyle(fontFamily: 'Inter', fontSize: 28, fontWeight: FontWeight.w600, color: DS.textPrimary),
    titleMedium:     TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600, color: DS.textPrimary),
    bodyMedium:      TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400, color: DS.textSecondary),
    labelMedium:     TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w500, color: DS.textSecondary),
  );
}
