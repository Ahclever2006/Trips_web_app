import 'package:flutter/material.dart';

class VDivider extends StatelessWidget {
  final double? height;
  const VDivider({required this.height, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFF2A2A2A),
    );
  }
}
