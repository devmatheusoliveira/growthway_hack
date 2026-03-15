import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/features/home/widgets/roadmap_sub_task_item_widget.dart';
import 'package:frontend/shared/models/roadmap_model.dart';

class RoadmapActiveTaskCardWidget extends StatelessWidget {
  final List<RoadmapTask> tasks;
  final String stageTitle;
  final String stageDescription;
  final String stageXp;
  final String? question;
  final String? answer;

  const RoadmapActiveTaskCardWidget({
    super.key,
    required this.tasks,
    required this.stageTitle,
    required this.stageDescription,
    required this.stageXp,
    this.question,
    this.answer,
    this.onTaskToggle,
  });

  final Function(String taskId, bool completed)? onTaskToggle;

  SubTaskState _getTaskState(String state) {
    switch (state) {
      case 'completed':
        return SubTaskState.completed;
      case 'active':
        return SubTaskState.active;
      case 'locked':
      default:
        return SubTaskState.locked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = tasks.where((t) => t.state == 'completed').length;

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
          ),
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
                      child: const Icon(
                        Icons.layers_outlined,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stageTitle,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Text(
                          stageDescription,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
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
                      stageXp,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      'RECOMPENSA POTENCIAL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.white.withAlpha(229),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                if (question != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.psychology_outlined,
                              color: AppColors.slate400,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'POR QUE VOCÊ ESTÁ AQUI?',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AppColors.slate400,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          question!,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.slate800,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(25),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primary.withAlpha(51),
                            ),
                          ),
                          child: Text(
                            'Sua resposta: $answer',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.slate100),
                  const SizedBox(height: 32),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUB-TAREFAS ATIVAS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.slate400,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '$completedCount de ${tasks.length} Concluídas',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ...tasks.map(
                  (task) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RoadmapSubTaskItemWidget(
                      title: task.title,
                      description: task.description,
                      xp: task.xp,
                      state: _getTaskState(task.state),
                      onTap: onTaskToggle != null
                          ? () => onTaskToggle!(
                              task.id,
                              task.state != 'completed',
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.primary),
                    foregroundColor: WidgetStateProperty.all(AppColors.white),
                    minimumSize: WidgetStateProperty.all(
                      const Size(double.infinity, 56),
                    ),
                    elevation: WidgetStateProperty.resolveWith((states) {
                      return states.contains(WidgetState.hovered) ? 15.0 : 10.0;
                    }),
                    shadowColor: WidgetStateProperty.resolveWith((states) {
                      return AppColors.primary.withAlpha(
                        states.contains(WidgetState.hovered) ? 102 : 76,
                      );
                    }),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bolt, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Continuar Construindo',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
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
