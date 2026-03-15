import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class ProfileStatsGridWidget extends StatelessWidget {
  const ProfileStatsGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: const [
        ProfileStatCardWidget(
          label: 'Mentorias',
          value: '12',
          icon: Icons.people_outline,
          color: Colors.blue,
        ),
        ProfileStatCardWidget(
          label: 'Desafios',
          value: '45',
          icon: Icons.emoji_events_outlined,
          color: Colors.orange,
        ),
        ProfileStatCardWidget(
          label: 'Ranking',
          value: '#42',
          icon: Icons.leaderboard_outlined,
          color: Colors.purple,
        ),
        ProfileStatCardWidget(
          label: 'Conquistas',
          value: '8',
          icon: Icons.auto_awesome_outlined,
          color: Colors.teal,
        ),
      ],
    );
  }
}

class ProfileStatCardWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const ProfileStatCardWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate900.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.slate900,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.slate500,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
