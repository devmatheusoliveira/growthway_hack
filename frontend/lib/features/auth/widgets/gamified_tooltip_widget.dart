import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class GamifiedTooltipWidget extends StatelessWidget {
  const GamifiedTooltipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(
          13,
        ), // 5% app_colors naming is strict, primary is Color(0xFF6BC80E)
        border: Border.all(color: AppColors.primary.withAlpha(26)), // 10%
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dica de XP:',
                  style: TextStyle(
                    color: AppColors.slate900,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Complete seu perfil após o login para ganhar o emblema "Early Adopter" e +500 pontos de reputação!',
                  style: TextStyle(
                    color: AppColors.slate600,
                    fontSize: 12,
                    height: 1.5,
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
