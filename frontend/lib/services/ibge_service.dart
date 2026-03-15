import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/shared/models/state_market_model.dart';

class IbgeService {
  static const String _baseUrlV1 = 'https://servicodados.ibge.gov.br/api/v1';
  static const String _baseUrlV3 = 'https://servicodados.ibge.gov.br/api/v3';

  static Future<List<StateMarketData>> fetchEstados() async {
    final response = await http.get(
      Uri.parse('$_baseUrlV1/localidades/estados?orderBy=nome'),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar estados: ${response.statusCode}');
    }
    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => StateMarketData.fromIbgeJson(e)).toList();
  }

  /// Busca a população residente de todos os estados via SIDRA (Tabela 9605 - Censo 2022)
  static Future<Map<String, double>> fetchPopulacaoEstados() async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrlV3/agregados/9605/periodos/-1/variaveis/93?localidades=N3[all]',
      ),
    );

    if (response.statusCode != 200) return {};

    final List<dynamic> data = json.decode(response.body);
    if (data.isEmpty) return {};

    final results = <String, double>{};
    final series = data[0]['resultados'][0]['series'] as List<dynamic>;

    for (var item in series) {
      if (item is Map && item.containsKey('localidade') && item.containsKey('serie')) {
        final id = item['localidade']['id']?.toString();
        final serie = item['serie'];
        
        if (id != null && serie is Map && serie.isNotEmpty) {
          final valorStr = serie.values.first?.toString() ?? '0';
          final valor = double.tryParse(valorStr) ?? 0.0;
          results[id] = valor;
        }
      }
    }

    return results;
  }

  /// Busca o número de unidades locais (Indicador de atividade econômica/concorrentes)
  /// Tabela 1685 - CEMPRE (Série encerrada em 2021 - dados mais recentes disponíveis para unidades locais)
  static Future<Map<String, int>> fetchEmpresasTechPorEstado() async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrlV3/agregados/1685/periodos/2021/variaveis/706?localidades=N3[all]',
      ),
    );

    if (response.statusCode != 200) return {};

    final List<dynamic> data = json.decode(response.body);
    if (data.isEmpty) return {};

    final results = <String, int>{};
    final resultados = data[0]['resultados'] as List<dynamic>;
    if (resultados.isEmpty) return {};
    
    final series = resultados[0]['series'] as List<dynamic>;

    for (var item in series) {
      if (item is Map &&
          item.containsKey('localidade') &&
          item.containsKey('serie')) {
        final id = item['localidade']['id']?.toString();
        final serie = item['serie'];

        if (id != null && serie is Map && serie.isNotEmpty) {
          final valorStr = serie.values.first?.toString() ?? '0';
          // O IBGE às vezes retorna '-' para dados não disponíveis
          if (valorStr == '-') continue;
          final valor = int.tryParse(valorStr) ?? 0;
          results[id] = valor;
        }
      }
    }

    return results;
  }

  /// Busca todos os municípios e agrupa por estado (mais eficiente que N requests)
  static Future<Map<int, int>> fetchTotalMunicipiosPorEstado() async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrlV1/localidades/municipios'));
      if (response.statusCode != 200) return {};

      final List<dynamic> data = json.decode(response.body);
      final results = <int, int>{};

      for (var mun in data) {
        if (mun is Map) {
          // Acesso seguro à hierarquia para evitar o erro NoSuchMethodError: '[]' em null
          final microrregiao = mun['microrregiao'];
          if (microrregiao != null && microrregiao is Map) {
            final mesorregiao = microrregiao['mesorregiao'];
            if (mesorregiao != null && mesorregiao is Map) {
              final uf = mesorregiao['UF'];
              if (uf != null && uf is Map) {
                final ufId = uf['id'];
                if (ufId is int) {
                  results[ufId] = (results[ufId] ?? 0) + 1;
                }
              }
            }
          }
        }
      }

      return results;
    } catch (e) {
      return {};
    }
  }
}
