import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class TeamDynamicsWidget extends StatelessWidget {
  const TeamDynamicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dinâmica da Equipe',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.slate900,
              ),
            ),
            const Row(
              children: [
                FilterIconButtonWidget(icon: Icons.filter_list),
                SizedBox(width: 8),
                FilterIconButtonWidget(icon: Icons.more_vert),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(
              child: TeamMetricCardWidget(
                title: 'Sinergia',
                value: '94%',
                icon: Icons.psychology,
                iconColor: Colors.blue,
                bgColor: Color(0xFFDBEAFE), // blue-100
                trendText: '+2.4% esta semana',
                trendIcon: Icons.trending_up,
                trendColor: AppColors.primary,
                progress: 0.94,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: TeamMetricCardWidget(
                title: 'Velocidade',
                value: '28 pts',
                icon: Icons.speed,
                iconColor: AppColors.primary,
                bgColor: Color(0x336BC80E), // primary/20
                trendText: 'Acima da média',
                trendIcon: Icons.trending_up,
                trendColor: AppColors.primary,
                progress: 0.78,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: TeamMetricCardWidget(
                title: 'Felicidade',
                value: '4.8/5',
                icon: Icons.favorite,
                iconColor: Colors.orange,
                bgColor: Color(0xFFFFEDD5), // orange-100
                trendText: 'Estado estável',
                trendIcon: Icons.horizontal_rule,
                trendColor: AppColors.slate400,
                progress: 0.96,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: TeamMetricCardWidget(
                title: 'Estabilidade',
                value: 'Alta',
                icon: Icons.security,
                iconColor: Colors.purple,
                bgColor: Color(0xFFF3E8FF), // purple-100
                trendText: 'Risco reduzido',
                trendIcon: Icons.trending_up,
                trendColor: AppColors.primary,
                progress: 0.82,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FilterIconButtonWidget extends StatelessWidget {
  final IconData icon;

  const FilterIconButtonWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8), // rounded-lg
      child: Container(
        padding: const EdgeInsets.all(8), // p-2
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.slate200),
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.slate500,
        ), // text-sm roughly
      ),
    );
  }
}

class TeamMetricCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String trendText;
  final IconData trendIcon;
  final Color trendColor;
  final double progress;

  const TeamMetricCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.trendText,
    required this.trendIcon,
    required this.trendColor,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24), // p-6
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16), // xl
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40, // size-10
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8), // lg
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: iconColor, size: 24),
              ),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2, // tracking-widest
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // mb-4
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900, // black
              color: AppColors.slate900,
            ),
          ),
          const SizedBox(height: 4), // mt-1
          Row(
            children: [
              Icon(trendIcon, size: 14, color: trendColor),
              const SizedBox(width: 4), // gap-1
              Text(
                trendText,
                style: const TextStyle(
                  fontSize:
                      10, // text-xs ? It maps to 12 in tailwind, so maybe 12
                  color: AppColors.slate500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // mt-4
          Container(
            height: 6, // h-1.5
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.slate100,
              borderRadius: BorderRadius.circular(9999), // full
            ),
            child: Row(
              children: [
                Expanded(
                  flex: (progress * 100).toInt(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: iconColor,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
                Expanded(
                  flex: 100 - (progress * 100).toInt(),
                  child: const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
