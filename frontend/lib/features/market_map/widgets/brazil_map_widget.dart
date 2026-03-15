import 'package:flutter/material.dart';
import 'package:frontend/features/market_map/data/brazil_map_paths.dart';
import 'package:frontend/features/market_map/widgets/brazil_map_painter.dart';

class BrazilMapWidget extends StatefulWidget {
  final String? selectedState;
  final Map<String, double> heatMapValues;
  final double maxHeatValue;
  final ValueChanged<String> onStateTap;

  const BrazilMapWidget({
    super.key,
    this.selectedState,
    this.heatMapValues = const {},
    this.maxHeatValue = 1,
    required this.onStateTap,
  });

  @override
  State<BrazilMapWidget> createState() => _BrazilMapWidgetState();
}

class _BrazilMapWidgetState extends State<BrazilMapWidget> {
  String? _hoveredState;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return MouseRegion(
          onHover: (event) {
            final hit = _hitTestState(event.localPosition, size);
            if (hit != _hoveredState) {
              setState(() => _hoveredState = hit);
            }
          },
          onExit: (_) => setState(() => _hoveredState = null),
          cursor: _hoveredState != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: GestureDetector(
            onTapDown: (details) {
              final hit = _hitTestState(details.localPosition, size);
              if (hit != null) {
                widget.onStateTap(hit);
              }
            },
            child: CustomPaint(
              size: size,
              painter: BrazilMapPainter(
                hoveredState: _hoveredState,
                selectedState: widget.selectedState,
                heatMapValues: widget.heatMapValues,
                maxHeatValue: widget.maxHeatValue,
              ),
            ),
          ),
        );
      },
    );
  }

  String? _hitTestState(Offset position, Size size) {
    final scaleX = size.width / BrazilMapPaths.mapWidth;
    final scaleY = size.height / BrazilMapPaths.mapHeight;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    final offsetX = (size.width - BrazilMapPaths.mapWidth * scale) / 2;
    final offsetY = (size.height - BrazilMapPaths.mapHeight * scale) / 2;

    final transformedPosition = Offset(
      (position.dx - offsetX) / scale,
      (position.dy - offsetY) / scale,
    );

    for (final stateData in BrazilMapPaths.states.reversed) {
      final path = BrazilMapPaths.getPath(stateData.sigla);
      if (path.contains(transformedPosition)) {
        return stateData.sigla;
      }
    }
    return null;
  }
}
