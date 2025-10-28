import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Lightweight helper wrapper around `SvgPicture.asset` to keep usages concise.
class SvgHelper {
  /// Loads an SVG asset with common defaults.
  ///
  /// [assetName] is the asset path (e.g. `Assets.logo`).
  static Widget asset(
    String assetName, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    String? semanticsLabel,
  }) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      color: color,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: (context) => SizedBox(width: width, height: height),
    );
  }
}
