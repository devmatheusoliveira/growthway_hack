import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/features/home/widgets/roadmap_sub_task_item_widget.dart';

class RoadmapActiveTaskCardWidget extends StatelessWidget {
  const RoadmapActiveTaskCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 672), // max-w-2xl
      margin: const EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.primary.withAlpha(51)),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate900.withAlpha(25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            color: AppColors.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.layers_outlined, color: AppColors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MVP Stage',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Text(
                          'Build your Minimum Viable Product',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.white.withAlpha(204),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '1,500 XP',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      'POTENTIAL REWARD',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.white.withAlpha(229),
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ACTIVE SUB-TASKS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.slate400,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                    ),
                    Text(
                      '2 of 4 Completed',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const RoadmapSubTaskItemWidget(
                  title: 'Define Core Features',
                  description: 'List top 3 must-have features',
                  xp: '+200 XP',
                  state: SubTaskState.completed,
                ),
                const SizedBox(height: 16),
                const RoadmapSubTaskItemWidget(
                  title: 'UI/UX Prototype',
                  description: 'Figma mockups for key screens',
                  xp: '+400 XP',
                  state: SubTaskState.completed,
                ),
                const SizedBox(height: 16),
                const RoadmapSubTaskItemWidget(
                  title: 'Technical Setup',
                  description: 'Database schema & server init',
                  xp: '+500 XP',
                  state: SubTaskState.active,
                ),
                const SizedBox(height: 16),
                const RoadmapSubTaskItemWidget(
                  title: 'Beta Launch',
                  description: 'Deploy to first 10 users',
                  xp: '+400 XP',
                  state: SubTaskState.locked,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.primary),
                    foregroundColor: WidgetStateProperty.all(AppColors.white),
                    minimumSize: WidgetStateProperty.all(const Size(double.infinity, 56)),
                    elevation: WidgetStateProperty.resolveWith((states) {
                      return states.contains(WidgetState.hovered) ? 15.0 : 10.0;
                    }),
                    shadowColor: WidgetStateProperty.resolveWith((states) {
                      return AppColors.primary.withAlpha(states.contains(WidgetState.hovered) ? 102 : 76);
                    }),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bolt, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Continue Building',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
