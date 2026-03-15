import 'dart:io';
import 'dart:math';

void main() async {
  final svgFile = File('br.svg');
  final svg = await svgFile.readAsString();
  // viewBox do br.svg
  const mapWidth = 1000.0;
  const mapHeight = 912.0;
  // Regexes para id e d
  final idRegex = RegExp(r'id="BR([A-Z]{2})"');
  final dRegex = RegExp(r'd="([^"]+)"');
  final pathTagsRegex = RegExp(r'<path[^>]*>', multiLine: true);
  final buffer = StringBuffer()
    ..writeln('class BrazilStatePathData {')
    ..writeln('  final String sigla;')
    ..writeln('  final String path;')
    ..writeln('  final double labelX;')
    ..writeln('  final double labelY;')
    ..writeln('')
    ..writeln('  const BrazilStatePathData({')
    ..writeln('    required this.sigla,')
    ..writeln('    required this.path,')
    ..writeln('    required this.labelX,')
    ..writeln('    required this.labelY,')
    ..writeln('  });')
    ..writeln('}')
    ..writeln('')
    ..writeln('class BrazilMapPaths {')
    ..writeln('  static const double mapWidth = $mapWidth;')
    ..writeln('  static const double mapHeight = $mapHeight;')
    ..writeln('')
    ..writeln('  static const List<BrazilStatePathData> states = [');
  for (final pathTagMatch in pathTagsRegex.allMatches(svg)) {
    final pathTag = pathTagMatch.group(0)!;
    final idMatch = idRegex.firstMatch(pathTag);
    final dMatch = dRegex.firstMatch(pathTag);
    
    if (idMatch == null || dMatch == null) continue;
    
    final uf = idMatch.group(1)!;
    final d = dMatch.group(1)!;
    // pega todos os números do d para estimar bbox
    final numRegex = RegExp(r'-?\d+\.?\d*');
    final nums = numRegex
        .allMatches(d)
        .map((m) => double.parse(m.group(0)!))
        .toList();
    // se não tiver coordenada suficiente, pula
    if (nums.length < 2) continue;
    double minX = double.infinity;
    double maxX = -double.infinity;
    double minY = double.infinity;
    double maxY = -double.infinity;
    // pares (x, y)
    for (int i = 0; i + 1 < nums.length; i += 2) {
      final x = nums[i];
      final y = nums[i + 1];
      minX = min(minX, x);
      maxX = max(maxX, x);
      minY = min(minY, y);
      maxY = max(maxY, y);
    }
    final labelX = (minX + maxX) / 2;
    final labelY = (minY + maxY) / 2;
    // escapa apóstrofos no path
    final escapedD = d.replaceAll("'", r"\'");
    buffer
      ..writeln('    BrazilStatePathData(')
      ..writeln("      sigla: '$uf',")
      ..writeln("      path: '$escapedD',")
      ..writeln('      labelX: ${labelX.toStringAsFixed(1)},')
      ..writeln('      labelY: ${labelY.toStringAsFixed(1)},')
      ..writeln('    ),');
  }
  buffer
    ..writeln('  ];')
    ..writeln('')
    ..writeln('  static BrazilStatePathData? getByUf(String sigla) {')
    ..writeln('    try {')
    ..writeln('      return states.firstWhere((s) => s.sigla == sigla);')
    ..writeln('    } catch (_) {')
    ..writeln('      return null;')
    ..writeln('    }')
    ..writeln('  }')
    ..writeln('}');
  final outFile = File('lib/features/market_map/data/brazil_map_paths.dart');
  await outFile.writeAsString(buffer.toString());
  print('brazil_map_paths.dart gerado a partir de br.svg.');
}
