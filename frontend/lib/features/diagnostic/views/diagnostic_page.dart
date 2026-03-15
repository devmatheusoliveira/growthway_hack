import 'package:flutter/material.dart';
import 'package:frontend/features/diagnostic/widgets/diagnostic_header_widget.dart';
import 'package:frontend/features/diagnostic/widgets/diagnostic_option_card_widget.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/widgets/sidebar_widget.dart';
import 'package:frontend/shared/routes/app_routes.dart';
import 'package:frontend/shared/models/diagnostic_model.dart';
import 'package:frontend/shared/services/diagnostic_service.dart';

class DiagnosticPage extends StatefulWidget {
  const DiagnosticPage({super.key});

  @override
  State<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> {
  final _service = DiagnosticService();

  DiagnosticNode? _currentNode;
  List<DiagnosticEdge> _edges = [];
  int _selectedIndex = -1;
  bool _isLoading = true;
  int _currentStep = 1;
  final int _totalSteps = 5; // Pode ser dinâmico no futuro

  @override
  void initState() {
    super.initState();
    _loadInitialNode();
  }

  Future<void> _loadInitialNode() async {
    setState(() => _isLoading = true);
    try {
      final node = await _service.getRootNode();
      if (node != null) {
        final edges = await _service.getEdgesForNode(node.id);
        setState(() {
          _currentNode = node;
          _edges = edges;
        });
      }
    } catch (e) {
      _showError('Erro ao carregar diagnóstico: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleNext() async {
    if (_selectedIndex == -1) return;

    final selectedEdge = _edges[_selectedIndex];

    setState(() => _isLoading = true);
    try {
      // Salva a resposta do usuário
      await _service.saveResponse(
        nodeId: _currentNode!.id,
        edgeId: selectedEdge.id,
      );

      // Carrega o próximo nó
      final nextNode = await _service.getNodeById(selectedEdge.toNodeId);
      if (nextNode != null) {
        if (nextNode.type == 'result') {
          // Se for um resultado, navegamos para o dashboard ou roadmap
          if (mounted) {
            Navigator.pushReplacementNamed(context, AppRoutes.roadmap);
          }
          return;
        }

        final nextEdges = await _service.getEdgesForNode(nextNode.id);
        setState(() {
          _currentNode = nextNode;
          _edges = nextEdges;
          _selectedIndex = -1;
          _currentStep++;
        });
      }
    } catch (e) {
      _showError('Erro ao processar resposta: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Row(
        children: [
          const SidebarWidget(activeIndex: 3),
          Expanded(
            child: Column(
              children: [
                if (_isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_currentNode == null)
                  const Expanded(
                    child: Center(
                      child: Text('Nenhum diagnóstico disponível.'),
                    ),
                  )
                else
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 896),
                            child: DiagnosticHeaderWidget(
                              currentStep: _currentStep,
                              totalSteps: _totalSteps,
                              progressPercentage: _currentStep / _totalSteps,
                            ),
                          ),
                        ),
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 896),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 48,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentNode!.title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          color: AppColors.slate900,
                                          fontWeight: FontWeight.w800,
                                          height: 1.2,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _currentNode!.content,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: AppColors.slate500),
                                  ),
                                  const SizedBox(height: 48),
                                  GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: 3.5,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: List.generate(_edges.length, (
                                      index,
                                    ) {
                                      final edge = _edges[index];
                                      return DiagnosticOptionCardWidget(
                                        title: edge.label,
                                        description: edge.description ?? '',
                                        isSelected: _selectedIndex == index,
                                        onTap: () {
                                          setState(() {
                                            _selectedIndex = index;
                                          });
                                        },
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 48),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            AppRoutes.dashboard,
                                          );
                                        },
                                        icon: const Icon(Icons.arrow_back),
                                        label: const Text('Voltar'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColors.slate700,
                                          backgroundColor: AppColors.slate200,
                                          side: BorderSide.none,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 20,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      ElevatedButton(
                                        onPressed: _selectedIndex != -1
                                            ? _handleNext
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 48,
                                            vertical: 20,
                                          ),
                                          elevation: 8,
                                          shadowColor: AppColors.primary
                                              .withAlpha(0.25 * 255 ~/ 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _selectedIndex != -1 &&
                                                      _edges[_selectedIndex]
                                                              .toNodeType ==
                                                          'result'
                                                  ? 'Finalizar Diagnóstico'
                                                  : 'Próximo Passo',
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(
                                              _selectedIndex != -1 &&
                                                      _edges[_selectedIndex]
                                                              .toNodeType ==
                                                          'result'
                                                  ? Icons.check_circle_outline
                                                  : Icons.arrow_forward,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Respostas salvas automaticamente • Sessão Ativa',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.slate400,
                      fontWeight: FontWeight.w500,
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
