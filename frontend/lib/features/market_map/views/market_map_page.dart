import 'package:flutter/material.dart';
import 'package:frontend/features/home/widgets/header_widget.dart';
import 'package:frontend/features/market_map/widgets/brazil_map_widget.dart';
import 'package:frontend/features/market_map/widgets/map_legend_widget.dart';
import 'package:frontend/features/market_map/widgets/map_loading_widget.dart';
import 'package:frontend/features/market_map/widgets/map_summary_card_widget.dart';
import 'package:frontend/features/market_map/widgets/state_detail_panel_widget.dart';
import 'package:frontend/services/ibge_service.dart';
import 'package:frontend/shared/models/state_market_model.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/widgets/sidebar_widget.dart';

class MarketMapPage extends StatefulWidget {
  const MarketMapPage({super.key});

  @override
  State<MarketMapPage> createState() => _MarketMapPageState();
}

class _MarketMapPageState extends State<MarketMapPage> {
  List<StateMarketData> _states = [];
  bool _isLoading = true;
  String? _selectedStateSigla;
  String? _errorMessage;
  String _selectedCnaeId = '117555';
  double _averageDensity = 0.0;

  final Map<String, String> _sectors = {
    '117555': 'Tecnologia / TIC',
    '117363': 'Comércio',
    '116910': 'Indústria',
    '117543': 'Gastronomia / Viagens',
    '117810': 'Saúde / Social',
    '117788': 'Educação',
    '117608': 'Finanças / Seguros',
    '117673': 'Serviços Técnicos',
    '117329': 'Construção Civil',
    '116830': 'Agronegócio',
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Fetch all data in parallel
      final results = await Future.wait([
        IbgeService.fetchEstados(),
        IbgeService.fetchTotalMunicipiosPorEstado(),
        IbgeService.fetchPopulacaoEstados(),
        IbgeService.fetchCompetidoresPorEstado(cnaeId: _selectedCnaeId),
      ]);

      final List<StateMarketData> estados = results[0] as List<StateMarketData>;
      final Map<int, int> municipios = results[1] as Map<int, int>;
      final Map<String, double> populacoes = results[2] as Map<String, double>;
      final Map<String, int> empresasTech = results[3] as Map<String, int>;

      final enrichedStates = estados.map((state) {
        final stateIdStr = state.id.toString();
        final pop = populacoes[stateIdStr] ?? 0.0;
        final techUnits = empresasTech[stateIdStr] ?? 0;
        
        // Calculate tech density per 100k inhabitants
        final density = pop > 0 ? (techUnits / pop) * 100000 : 0.0;
        
        return state.copyWith(
          quantidadeMunicipios: municipios[state.id] ?? 0,
          quantidadeConcorrentes: techUnits,
          populacao: pop,
          densidadePor100k: density,
        );
      }).toList();

      setState(() {
        _states = enrichedStates;
        _averageDensity = enrichedStates.isNotEmpty
            ? enrichedStates.fold(0.0, (sum, s) => sum + s.densidadePor100k) /
                enrichedStates.length
            : 0.0;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erro ao carregar dados: $e';
      });
    }
  }

  StateMarketData? get _selectedState {
    if (_selectedStateSigla == null) return null;
    try {
      return _states.firstWhere((s) => s.sigla == _selectedStateSigla);
    } catch (_) {
      return null;
    }
  }

  Map<String, double> get _heatMapValues {
    final map = <String, double>{};
    for (final state in _states) {
      map[state.sigla] = state.densidadePor100k;
    }
    return map;
  }

  double get _maxHeatValue {
    if (_states.isEmpty) return 1;
    return _states
        .map((s) => s.densidadePor100k)
        .reduce((a, b) => a > b ? a : b);
  }

  int get _totalConcorrentes {
    return _states.fold(0, (sum, s) => sum + s.quantidadeConcorrentes);
  }

  int get _totalMunicipios {
    return _states.fold(0, (sum, s) => sum + s.quantidadeMunicipios);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Row(
        children: [
          const SidebarWidget(activeIndex: 2),
          Expanded(
            child: Column(
              children: [
                const HeaderWidget(
                  title: 'Mapa de Mercado',
                  icon: Icons.map_outlined,
                ),
                if (_isLoading)
                  const Expanded(child: MapLoadingWidget())
                else if (_errorMessage != null)
                  Expanded(
                    child: _ErrorContent(
                      message: _errorMessage!,
                      onRetry: _loadData,
                    ),
                  )
                else
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildSectorSelector(),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 90,
                            child: Row(
                              children: [
                                Expanded(
                                  child: MapSummaryCardWidget(
                                    icon: Icons.flag,
                                    label: 'Estados',
                                    value: _states.length.toString(),
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MapSummaryCardWidget(
                                    icon: Icons.location_city,
                                    label: 'Municípios',
                                    value: _formatNumber(_totalMunicipios),
                                    color: const Color(0xFF3B82F6),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MapSummaryCardWidget(
                                    icon: Icons.store,
                                    label: 'Concorrentes',
                                    value: _formatNumber(_totalConcorrentes),
                                    color: const Color(0xFFF59E0B),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MapSummaryCardWidget(
                                    icon: Icons.trending_up,
                                    label: 'Maior densidade',
                                    value: _getTopDensityState(),
                                    color: const Color(0xFF8B5CF6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.slate900.withAlpha(
                                            8,
                                          ),
                                          blurRadius: 20,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: BrazilMapWidget(
                                            selectedState: _selectedStateSigla,
                                            heatMapValues: _heatMapValues,
                                            maxHeatValue: _maxHeatValue,
                                            onStateTap: (sigla) {
                                              setState(() {
                                                _selectedStateSigla =
                                                    _selectedStateSigla == sigla
                                                    ? null
                                                    : sigla;
                                              });
                                            },
                                          ),
                                        ),
                                        const Positioned(
                                          left: 20,
                                          bottom: 20,
                                          child: MapLegendWidget(),
                                        ),
                                        if (_selectedStateSigla == null)
                                          Positioned(
                                            right: 20,
                                            top: 20,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColors.slate100,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.touch_app,
                                                    size: 18,
                                                    color: AppColors.slate500,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Clique em um estado para ver detalhes',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color: AppColors
                                                              .slate500,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (_selectedState != null) ...[
                                  const SizedBox(width: 20),
                                  StateDetailPanelWidget(
                                    stateData: _selectedState!,
                                    sectorName: _sectors[_selectedCnaeId] ?? '',
                                    averageDensity: _averageDensity,
                                    onClose: () {
                                      setState(
                                        () => _selectedStateSigla = null,
                                      );
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  String _getTopDensityState() {
    if (_states.isEmpty) return '-';
    final top = _states.reduce(
      (a, b) => a.densidadePor100k > b.densidadePor100k ? a : b,
    );
    return '${top.sigla} (${top.densidadePor100k.toStringAsFixed(1)})';
  }

  Widget _buildSectorSelector() {
    return Container(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _sectors.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final entry = _sectors.entries.elementAt(index);
          final isSelected = _selectedCnaeId == entry.key;

          return FilterChip(
            label: Text(entry.value),
            selected: isSelected,
            onSelected: (selected) {
              if (selected && !isSelected) {
                setState(() {
                  _selectedCnaeId = entry.key;
                  _selectedStateSigla = null;
                });
                _loadData();
              }
            },
            selectedColor: AppColors.primary.withAlpha(51),
            checkmarkColor: AppColors.primary,
            labelStyle: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.slate600,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 13,
            ),
            backgroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.slate200,
                width: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorContent({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 56, color: AppColors.slate400),
          const SizedBox(height: 16),
          Text(
            'Ops! Algo deu errado',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.slate700,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 400,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.slate500),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Tentar novamente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}
