import 'package:flutter/material.dart';
import 'package:frontend/shared/models/state_market_model.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class StateDetailPanelWidget extends StatelessWidget {
  final StateMarketData stateData;
  final VoidCallback onClose;

  const StateDetailPanelWidget({
    super.key,
    required this.stateData,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate900.withAlpha(20),
            blurRadius: 40,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StateDetailHeaderSection(stateData: stateData, onClose: onClose),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              children: [
                _StatMetricRow(
                  icon: Icons.location_city,
                  label: 'Municípios',
                  value: stateData.quantidadeMunicipios.toString(),
                  color: const Color(0xFF3B82F6),
                ),
                const SizedBox(height: 12),
                _StatMetricRow(
                  icon: Icons.store,
                  label: 'Concorrentes',
                  value: stateData.quantidadeConcorrentes.toString(),
                  color: const Color(0xFFF59E0B),
                ),
                const SizedBox(height: 12),
                _StatMetricRow(
                  icon: Icons.people,
                  label: 'Pop. estimada',
                  value: _formatPopulation(stateData.populacao),
                  color: const Color(0xFF8B5CF6),
                ),
                const SizedBox(height: 12),
                _StatMetricRow(
                  icon: Icons.show_chart,
                  label: 'Densidade conc./100k hab.',
                  value: stateData.densidadePor100k.toStringAsFixed(1),
                  color: AppColors.primary,
                ),
                const SizedBox(height: 24),
                _MarketInsightSection(stateData: stateData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPopulation(double pop) {
    if (pop >= 1000000) {
      return '${(pop / 1000000).toStringAsFixed(1)}M';
    } else if (pop >= 1000) {
      return '${(pop / 1000).toStringAsFixed(0)}k';
    }
    return pop.toInt().toString();
  }
}

class _StateDetailHeaderSection extends StatelessWidget {
  final StateMarketData stateData;
  final VoidCallback onClose;

  const _StateDetailHeaderSection({
    required this.stateData,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary.withAlpha(200)],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  stateData.sigla,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, color: AppColors.white),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.white.withAlpha(30),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            stateData.nome,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Região ${stateData.regiao}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.white.withAlpha(230),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatMetricRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatMetricRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.slate500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.slate900,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketInsightSection extends StatelessWidget {
  final StateMarketData stateData;

  const _MarketInsightSection({required this.stateData});

  @override
  Widget build(BuildContext context) {
    final level = _getMarketLevel();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [level.color.withAlpha(20), level.color.withAlpha(8)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: level.color.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: level.color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Insight de Mercado',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.slate900,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: level.color.withAlpha(30),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              level.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: level.color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            level.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.slate600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  _MarketLevel _getMarketLevel() {
    if (stateData.densidadePor100k > 5) {
      return _MarketLevel(
        label: 'MERCADO SATURADO',
        description:
            'Alta concentração de concorrentes. Diferenciação agressiva necessária para entrada.',
        color: const Color(0xFFEF4444),
      );
    } else if (stateData.densidadePor100k > 2) {
      return _MarketLevel(
        label: 'MERCADO COMPETITIVO',
        description:
            'Concorrência moderada. Há espaço para novos players com proposta de valor clara.',
        color: const Color(0xFFF59E0B),
      );
    } else if (stateData.densidadePor100k > 0.5) {
      return _MarketLevel(
        label: 'OPORTUNIDADE',
        description:
            'Baixa concorrência relativa à população. Excelente janela de oportunidade.',
        color: AppColors.primary,
      );
    }
    return _MarketLevel(
      label: 'MERCADO INEXPLORADO',
      description:
          'Presença mínima de concorrentes. Alto potencial de first-mover advantage.',
      color: const Color(0xFF3B82F6),
    );
  }
}

class _MarketLevel {
  final String label;
  final String description;
  final Color color;

  const _MarketLevel({
    required this.label,
    required this.description,
    required this.color,
  });
}
