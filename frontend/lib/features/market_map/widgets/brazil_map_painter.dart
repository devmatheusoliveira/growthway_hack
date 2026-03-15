import 'package:flutter/material.dart';
import 'package:frontend/features/market_map/data/brazil_map_paths.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class BrazilMapPainter extends CustomPainter {
  final String? hoveredState;
  final String? selectedState;
  final Map<String, double> heatMapValues;
  final double maxHeatValue;

  BrazilMapPainter({
    this.hoveredState,
    this.selectedState,
    this.heatMapValues = const {},
    this.maxHeatValue = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / BrazilMapPaths.mapWidth;
    final scaleY = size.height / BrazilMapPaths.mapHeight;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    final offsetX = (size.width - BrazilMapPaths.mapWidth * scale) / 2;
    final offsetY = (size.height - BrazilMapPaths.mapHeight * scale) / 2;

    canvas.save();
    canvas.translate(offsetX, offsetY);
    canvas.scale(scale);

    for (final stateData in BrazilMapPaths.states) {
      final path = BrazilMapPaths.getPath(stateData.sigla);
      final isHovered = stateData.sigla == hoveredState;
      final isSelected = stateData.sigla == selectedState;

      final fillPaint = Paint()..style = PaintingStyle.fill;
      final strokePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isHovered || isSelected ? 2.0 : 0.8;

      if (isSelected) {
        fillPaint.color = AppColors.primary;
        strokePaint.color = AppColors.primary;
      } else if (isHovered) {
        fillPaint.color = AppColors.primary.withAlpha(102);
        strokePaint.color = AppColors.primary;
      } else if (heatMapValues.containsKey(stateData.sigla)) {
        final normalizedValue = (heatMapValues[stateData.sigla]! / maxHeatValue)
            .clamp(0.0, 1.0);
        fillPaint.color = Color.lerp(
          AppColors.white,
          AppColors.primary,
          normalizedValue,
        )!;
        strokePaint.color = AppColors.white.withAlpha(200);
      } else {
        fillPaint.color = AppColors.slate200;
        strokePaint.color = AppColors.slate400.withAlpha(150);
      }

      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, strokePaint);

      if (isHovered || isSelected) {
        final shadowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = AppColors.primary.withAlpha(40)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
        canvas.drawPath(path, shadowPaint);
      }

      _drawStateLabel(
        canvas,
        stateData.sigla,
        path,
        scale,
        isSelected: isSelected,
        isHovered: isHovered,
      );
    }

    canvas.restore();
  }

  void _drawStateLabel(
    Canvas canvas,
    String sigla,
    Path path,
    double scale, {
    bool isSelected = false,
    bool isHovered = false,
  }) {
    // Calculate center of the state path for better label positioning
    final bounds = path.getBounds();
    final center = bounds.center;

    final textPainter = TextPainter(
      text: TextSpan(
        text: sigla,
        style: TextStyle(
          color: isSelected
              ? AppColors.white
              : isHovered
                  ? AppColors.slate900
                  : AppColors.slate600,
          // Normalize font size so it remains readable regardless of map scale
          fontSize: (isHovered || isSelected ? 11 : 9) / scale,
          fontWeight:
              isSelected || isHovered ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();
    
    // Position the label exactly at the center of the bounding box
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant BrazilMapPainter oldDelegate) {
    return oldDelegate.hoveredState != hoveredState ||
        oldDelegate.selectedState != selectedState ||
        oldDelegate.heatMapValues != heatMapValues;
  }
}
