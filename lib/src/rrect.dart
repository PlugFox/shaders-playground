import 'dart:developer';
import 'dart:ui' as ui show FragmentProgram, FragmentShader;

import 'package:flutter/widgets.dart';

/// {@template rrect}
/// RRect widget.
/// {@endtemplate}
class RoundedRectangle extends StatelessWidget {
  /// {@macro rrect}
  const RoundedRectangle({
    this.color,
    this.radius,
    this.borderColor = const Color(0x7F000000),
    this.borderWidth = 1,
    super.key,
  });

  /// The color used for the rrect.
  final Color? color;

  /// Radius of the rrect.
  final double? radius;

  /// Border color.
  final Color borderColor;

  /// Border thickness.
  final double borderWidth;

  /// Init shader.
  static final Future<ui.FragmentShader?> _shaderFuture =
      ui.FragmentProgram.fromAsset('assets/shaders/rrect.frag')
          .then<ui.FragmentShader?>((program) => program.fragmentShader(),
              onError: (error, __) {
    log('Failed to load shader: $error');
    return false;
  });

  @override
  Widget build(BuildContext context) => FutureBuilder<ui.FragmentShader?>(
        initialData: null,
        future: _shaderFuture,
        builder: (context, snapshot) => CustomPaint(
          painter: _RRectPainter(
            shader: snapshot.data,
            color: color ?? const Color(0x7FE0E0E0),
            radius: radius ?? 16,
            borderColor: borderColor,
            borderWidth: borderWidth,
          ),
        ),
      );
}

/// {@template rrect}
/// _RRectPainter.
/// {@endtemplate}
class _RRectPainter extends CustomPainter {
  /// {@macro rrect}
  const _RRectPainter({
    required this.color,
    required this.radius,
    required this.borderColor,
    required this.borderWidth,
    required this.shader,
  });

  final Color color;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final ui.FragmentShader? shader;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    if (shader == null) {
      return canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(radius)),
          Paint()..color = const Color(0x7FFF0000) /* color */);
    }
    final paint = Paint()
      ..shader = (shader!
        ..setFloat(0, size.width) // Width
        ..setFloat(1, size.height) // Height
        ..setFloat(2, color.red / 255) // Red
        ..setFloat(3, color.green / 255) // Green
        ..setFloat(4, color.blue / 255) // Blue
        ..setFloat(5, color.alpha / 255) // Alpha
        ..setFloat(6, radius) // Radius
        ..setFloat(7, borderColor.red / 255) // Border Red
        ..setFloat(8, borderColor.green / 255) // Border Green
        ..setFloat(9, borderColor.blue / 255) // Border Blue
        ..setFloat(10, borderColor.alpha / 255) // Border Alpha
        ..setFloat(11, borderWidth)) // Border Width
      ..blendMode = BlendMode.srcOver;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _RRectPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.radius != radius ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.borderWidth != borderWidth ||
      oldDelegate.shader != shader;
}
