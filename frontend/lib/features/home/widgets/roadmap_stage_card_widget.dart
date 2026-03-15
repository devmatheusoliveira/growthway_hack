import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class RoadmapStageCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String xp;
  final bool isCompleted;
  final bool isLocked;

  const RoadmapStageCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.xp,
    this.isCompleted = false,
    this.isLocked = false,
  });

  @override
  State<RoadmapStageCardWidget> createState() => _RoadmapStageCardWidgetState();
}

class _RoadmapStageCardWidgetState extends State<RoadmapStageCardWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.isLocked ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered && !widget.isLocked ? -4.0 : 0, 0),
        width: 256, // w-64
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: widget.isLocked
              ? null
              : Border(bottom: BorderSide(color: AppColors.primary.withAlpha(102), width: 4)),
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
              )
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: widget.isLocked
                        ? AppColors.slate200
                        : AppColors.primary.withAlpha(51),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.isLocked
                        ? 'LOCKED'
                        : (widget.isCompleted ? 'COMPLETED' : 'ACTIVE'),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: widget.isLocked ? AppColors.slate400 : AppColors.slate900,
                    fontWeight: FontWeight.w800,
                  ),
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
    );
  }
}
