class StateMarketData {
  final int id;
  final String sigla;
  final String nome;
  final String regiao;
  final int quantidadeMunicipios;
  final int quantidadeConcorrentes;
  final double densidadePor100k;
  final double populacao;

  StateMarketData({
    required this.id,
    required this.sigla,
    required this.nome,
    required this.regiao,
    required this.quantidadeMunicipios,
    this.quantidadeConcorrentes = 0,
    this.densidadePor100k = 0,
    this.populacao = 0,
  });

  factory StateMarketData.fromIbgeJson(Map<String, dynamic> json) {
    return StateMarketData(
      id: json['id'],
      sigla: json['sigla'],
      nome: json['nome'],
      regiao: json['regiao']['nome'],
      quantidadeMunicipios: 0,
    );
  }

  StateMarketData copyWith({
    int? quantidadeMunicipios,
    int? quantidadeConcorrentes,
    double? densidadePor100k,
    double? populacao,
  }) {
    return StateMarketData(
      id: id,
      sigla: sigla,
      nome: nome,
      regiao: regiao,
      quantidadeMunicipios: quantidadeMunicipios ?? this.quantidadeMunicipios,
      quantidadeConcorrentes:
          quantidadeConcorrentes ?? this.quantidadeConcorrentes,
      densidadePor100k: densidadePor100k ?? this.densidadePor100k,
      populacao: populacao ?? this.populacao,
    );
  }
}
