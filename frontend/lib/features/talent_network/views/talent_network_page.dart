import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/widgets/sidebar_widget.dart';
import 'package:frontend/features/talent_network/models/talent_profile_model.dart';
import 'package:frontend/features/talent_network/services/talent_network_service.dart';
import 'package:frontend/features/talent_network/widgets/talent_profile_card_widget.dart';
import 'package:frontend/features/talent_network/widgets/talent_profile_detail_modal.dart';
import 'package:frontend/features/talent_network/widgets/talent_stats_bar_widget.dart';

class TalentNetworkPage extends StatefulWidget {
  const TalentNetworkPage({super.key});

  @override
  State<TalentNetworkPage> createState() => _TalentNetworkPageState();
}

class _TalentNetworkPageState extends State<TalentNetworkPage> {
  final _service = TalentNetworkService();

  String _searchQuery = '';
  String _selectedFilter = 'Todos';
  List<TalentProfileModel> _allTalents = [];
  bool _isLoading = true;
  String? _error;

  static const List<String> _filters = [
    'Todos',
    'Desenvolvedor',
    'Designer',
    'Marketing',
    'Data',
    'Product',
    'Growth',
  ];

  @override
  void initState() {
    super.initState();
    _loadTalents();
  }

  Future<void> _loadTalents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final talents = await _service.getTalents();
      setState(() {
        _allTalents = talents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Não foi possível carregar os talentos.';
        _isLoading = false;
      });
    }
  }

  List<TalentProfileModel> get _filteredTalents {
    return _allTalents.where((talent) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          talent.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          talent.role.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          talent.skills.any(
            (s) => s.toLowerCase().contains(_searchQuery.toLowerCase()),
          );

      final matchesFilter =
          _selectedFilter == 'Todos' ||
          talent.role.toLowerCase().contains(
            _selectedFilter.toLowerCase(),
          );

      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _showProfileModal(TalentProfileModel talent) {
    showDialog(
      context: context,
      builder: (_) => TalentProfileDetailModal(talent: talent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Row(
        children: [
          const SidebarWidget(activeIndex: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TalentNetworkHeader(
                  searchQuery: _searchQuery,
                  onSearchChanged: (value) =>
                      setState(() => _searchQuery = value),
                ),
                Expanded(
                  child: _isLoading
                      ? const _LoadingState()
                      : _error != null
                      ? _ErrorState(
                          message: _error!,
                          onRetry: _loadTalents,
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TalentStatsBarWidget(),
                              const SizedBox(height: 28),
                              _FilterChips(
                                filters: _filters,
                                selectedFilter: _selectedFilter,
                                onFilterSelected: (filter) =>
                                    setState(() => _selectedFilter = filter),
                              ),
                              const SizedBox(height: 20),
                              _TalentGrid(
                                talents: _filteredTalents,
                                onViewProfile: _showProfileModal,
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
}

class _TalentNetworkHeader extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const _TalentNetworkHeader({
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 28, 32, 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rede de Talentos',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Encontre os melhores profissionais para acelerar sua startup.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.slate500,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 280,
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Buscar talentos...',
                hintStyle: const TextStyle(
                  color: AppColors.slate400,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.slate400,
                  size: 20,
                ),
                filled: true,
                fillColor: AppColors.slate50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.slate200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.slate200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const _FilterChips({
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;
          return GestureDetector(
            onTap: () => onFilterSelected(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.slate200,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(51),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.slate600,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TalentGrid extends StatelessWidget {
  final List<TalentProfileModel> talents;
  final void Function(TalentProfileModel) onViewProfile;

  const _TalentGrid({required this.talents, required this.onViewProfile});

  @override
  Widget build(BuildContext context) {
    if (talents.isEmpty) {
      return const _EmptyState();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      itemCount: talents.length,
      itemBuilder: (_, index) => TalentProfileCardWidget(
        talent: talents[index],
        onViewProfile: () => onViewProfile(talents[index]),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 64,
            color: AppColors.slate300,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.slate500,
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Tentar novamente'),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 80),
          const Icon(
            Icons.search_off_rounded,
            size: 64,
            color: AppColors.slate300,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum talento encontrado',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.slate500,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tente ajustar os filtros ou a busca.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.slate400,
            ),
          ),
        ],
      ),
    );
  }
}
