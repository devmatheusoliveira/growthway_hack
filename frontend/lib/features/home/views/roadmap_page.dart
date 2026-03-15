import 'package:flutter/material.dart';
import 'package:frontend/features/home/widgets/global_rank_badge_widget.dart';
import 'package:frontend/features/home/widgets/header_widget.dart';
import 'package:frontend/features/home/widgets/roadmap_active_task_card_widget.dart';
import 'package:frontend/features/home/widgets/roadmap_connector_widget.dart';
import 'package:frontend/features/home/widgets/roadmap_stage_card_widget.dart';
import 'package:frontend/features/home/widgets/roadmap_stage_row_widget.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/widgets/sidebar_widget.dart';

class RoadmapPage extends StatelessWidget {
  const RoadmapPage({super.key});

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
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'From Idea to Scale',
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                    color: AppColors.slate900,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Follow the path, complete tasks, and evolve your startup.',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.slate500,
                                  ),
                            ),
                            const SizedBox(height: 48),
                            const RoadmapStageRowWidget(
                              direction: StageDirection.left,
                              childCard: RoadmapStageCardWidget(
                                title: 'Idea Stage',
                                description: 'Market research & problem identification.',
                                xp: '500 XP',
                                isCompleted: true,
                              ),
                            ),
                            const RoadmapConnectorWidget(isSolid: true),
                            const RoadmapStageRowWidget(
                              direction: StageDirection.right,
                              childCard: RoadmapStageCardWidget(
                                title: 'Validation',
                                description: 'Customer interviews & landing pages.',
                                xp: '800 XP',
                                isCompleted: true,
                              ),
                            ),
                            const RoadmapConnectorWidget(isHalf: true),
                            const RoadmapStageRowWidget(
                              direction: StageDirection.centerExpanded,
                              childCard: RoadmapActiveTaskCardWidget(),
                            ),
                            const RoadmapConnectorWidget(isEnd: true),
                            const Opacity(
                              opacity: 0.4,
                              child: RoadmapStageRowWidget(
                                direction: StageDirection.leftLocked,
                                childCard: RoadmapStageCardWidget(
                                  title: 'Scale Stage',
                                  description: 'Reach thousands of active users.',
                                  xp: '2,000 XP',
                                  isLocked: true,
                                ),
                              ),
                            ),
                          ],
                        ),
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
}
