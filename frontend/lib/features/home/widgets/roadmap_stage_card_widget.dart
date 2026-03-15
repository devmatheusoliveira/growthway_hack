import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/models/roadmap_model.dart';
import 'package:frontend/features/home/widgets/roadmap_sub_task_item_widget.dart';

class RoadmapStageCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String xp;
  final bool isCompleted;
  final bool isLocked;
  final String? question;
  final String? answer;
  final List<RoadmapTask> tasks;
  final Function(String taskId, bool completed)? onTaskToggle;

  const RoadmapStageCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.xp,
    this.isCompleted = false,
    this.isLocked = false,
    this.question,
    this.answer,
    this.tasks = const [],
    this.onTaskToggle,
  });

  @override
  State<RoadmapStageCardWidget> createState() => _RoadmapStageCardWidgetState();
}

class _RoadmapStageCardWidgetState extends State<RoadmapStageCardWidget> {
  bool _isHovered = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: widget.isLocked
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.isLocked
                ? null
                : () => setState(() => _isExpanded = !_isExpanded),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(
                0,
                _isHovered && !widget.isLocked ? -4.0 : 0,
                0,
              ),
              width: 256, // w-64
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: widget.isLocked
                    ? null
                    : Border(
                        bottom: BorderSide(
                          color: AppColors.primary.withAlpha(102),
                          width: 4,
                        ),
                      ),
                boxShadow: [
                  if (widget.isLocked)
                    BoxShadow(
                      color: AppColors.slate900.withAlpha(25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  else
                    BoxShadow(
                      color: AppColors.slate900.withAlpha(_isHovered ? 40 : 25),
                      blurRadius: _isHovered ? 25 : 20,
                      offset: Offset(0, _isHovered ? 15 : 10),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: widget.isLocked
                              ? AppColors.slate200
                              : AppColors.primary.withAlpha(51),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.isLocked
                              ? 'BLOQUEADO'
                              : (widget.isCompleted ? 'CONCLUÍDO' : 'ATIVO'),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: widget.isLocked
                                    ? AppColors.slate500
                                    : AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      Text(
                        widget.xp,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.slate400,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: widget.isLocked
                                    ? AppColors.slate400
                                    : AppColors.slate900,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      if (!widget.isLocked && (widget.question != null || widget.tasks.isNotEmpty))
                        Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: AppColors.slate400,
                          size: 20,
                        ),
                    ],
                  ),
                  if (!widget.isLocked) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (_isExpanded && (widget.question != null || widget.tasks.isNotEmpty))
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 320, // Aumentado para acomodar tarefas
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.question != null) ...[
                  Text(
                    'DIAGNÓSTICO',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.slate400,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.question!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.slate700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: AppColors.primary.withAlpha(51)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: AppColors.primary,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            widget.answer!,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.tasks.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: AppColors.slate200),
                    const SizedBox(height: 16),
                  ],
                ],
                if (widget.tasks.isNotEmpty) ...[
                  Text(
                    'TAREFAS',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.slate400,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: RoadmapSubTaskItemWidget(
                        title: task.title,
                        description: '', // Descrição curta para o card menor
                        xp: task.xp,
                        state: task.state == 'completed'
                            ? SubTaskState.completed
                            : (widget.isCompleted
                                ? SubTaskState.completed
                                : SubTaskState.active),
                        onTap: widget.onTaskToggle != null
                            ? () => widget.onTaskToggle!(
                                task.id,
                                task.state != 'completed',
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
