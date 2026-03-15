import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class GlobalRankBadgeWidget extends StatelessWidget {
  const GlobalRankBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withAlpha(76)),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate900.withAlpha(25),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(
                Icons.emoji_events_outlined, // trophy
                color: AppColors.primary,
                size: 32,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'GLOBAL RANK',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    fontSize: 10,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.slate900,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      const TextSpan(text: '#452 '),
                      TextSpan(
                        text: '/ 12,402',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.slate400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.share_outlined, color: AppColors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
