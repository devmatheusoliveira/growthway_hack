import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class MapLegendWidget extends StatelessWidget {
  const MapLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate900.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Densidade de concorrentes',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.slate700,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 160,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE8F5E9),
                      Color(0xFF81C784),
                      Color(0xFF4CAF50),
                      Color(0xFF2E7D32),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Baixa',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.slate500),
              ),
              const SizedBox(width: 110),
              Text(
                'Alta',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.slate500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
