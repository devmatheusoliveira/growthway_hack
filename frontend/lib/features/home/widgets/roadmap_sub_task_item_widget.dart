import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

enum SubTaskState { completed, active, locked }

class RoadmapSubTaskItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String xp;
  final SubTaskState state;

  const RoadmapSubTaskItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.xp,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state == SubTaskState.locked) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Opacity(
          opacity: 0.5,
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.slate300, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Icon(Icons.lock_outline, size: 14, color: AppColors.slate400),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.slate400,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.slate400,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                xp,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.slate400,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    if (state == SubTaskState.active) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(13),
          border: Border.all(color: AppColors.primary.withAlpha(51), width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary.withAlpha(178),
                        ),
                  ),
                ],
              ),
            ),
            Text(
              xp,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
      );
    }

    // Default: Completed
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        border: Border.all(color: AppColors.slate100),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Icon(Icons.check, size: 16, color: AppColors.white),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.slate800,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.slate500,
                      ),
                ),
              ],
            ),
          ),
          Text(
            xp,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.slate400,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
