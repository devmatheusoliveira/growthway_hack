import 'package:flutter/material.dart';
import 'package:frontend/features/home/widgets/global_rank_badge_widget.dart';
import 'package:frontend/features/home/widgets/header_widget.dart';
import 'package:frontend/features/home/widgets/roadmap_active_task_card_widget.dart';
import 'package:frontend/features/home/widgets/roadmap_connector_widget.dart';
import 'package:frontend/features/home/widgets/roadmap_stage_card_widget.dart';
import 'package:frontend/features/home/widgets/roadmap_stage_row_widget.dart';
import 'package:frontend/shared/models/roadmap_model.dart';
import 'package:frontend/shared/services/roadmap_service.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/widgets/sidebar_widget.dart';

class RoadmapPage extends StatefulWidget {
  const RoadmapPage({super.key});

  @override
  State<RoadmapPage> createState() => _RoadmapPageState();
}

class _RoadmapPageState extends State<RoadmapPage> {
  final RoadmapService _roadmapService = RoadmapService();
  late Future<List<RoadmapStage>> _roadmapFuture;

  @override
  void initState() {
    super.initState();
    _roadmapFuture = _roadmapService.getRoadmap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SidebarWidget(),
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    const HeaderWidget(),
                    Expanded(
                      child: FutureBuilder<List<RoadmapStage>>(
                        future: _roadmapFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Erro ao carregar roadmap: ${snapshot.error}',
                              ),
                            );
                          }

                          final stages = snapshot.data ?? [];

                          return SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 48,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Da Ideia à Escala',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        color: AppColors.slate900,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Siga o caminho, complete tarefas e evolua sua startup.',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(color: AppColors.slate500),
                                ),
                                const SizedBox(height: 48),
                                ..._buildRoadmapItems(stages),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  bottom: 32,
                  right: 32,
                  child: GlobalRankBadgeWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRoadmapItems(List<RoadmapStage> stages) {
    final List<Widget> items = [];

    for (int i = 0; i < stages.length; i++) {
      final stage = stages[i];
      final isLast = i == stages.length - 1;

      if (stage.isActive) {
        items.add(
          RoadmapStageRowWidget(
            direction: StageDirection.centerExpanded,
            childCard: RoadmapActiveTaskCardWidget(
              tasks: stage.tasks,
              stageTitle: stage.title,
              stageDescription: stage.description,
              stageXp: stage.xp,
              question: stage.question,
              answer: stage.answer,
            ),
          ),
        );
      } else {
        StageDirection direction;
        if (stage.isLocked) {
          direction = StageDirection.leftLocked;
        } else {
          direction = i % 2 == 0 ? StageDirection.left : StageDirection.right;
        }

        Widget card = RoadmapStageCardWidget(
          title: stage.title,
          description: stage.description,
          xp: stage.xp,
          isCompleted: stage.isCompleted,
          isLocked: stage.isLocked,
          question: stage.question,
          answer: stage.answer,
        );

        if (stage.isLocked) {
          card = Opacity(opacity: 0.4, child: card);
        }

        items.add(RoadmapStageRowWidget(direction: direction, childCard: card));
      }

      if (!isLast) {
        final nextStage = stages[i + 1];
        bool isNextActive = nextStage.isActive;
        items.add(
          RoadmapConnectorWidget(
            isSolid:
                stage.isCompleted &&
                (nextStage.isCompleted || nextStage.isActive),
            isHalf: isNextActive,
            isEnd: nextStage.isLocked && !isNextActive,
          ),
        );
      }
    }

    return items;
  }
}
