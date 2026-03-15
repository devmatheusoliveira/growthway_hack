import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class FounderHeroWidget extends StatelessWidget {
  const FounderHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24), // xl
        border: Border.all(color: AppColors.slate200),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0a000000), // shadow-sm
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FounderAvatarWidget(),
              const SizedBox(width: 32), // gap-8
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bem-vindo de volta, Comandante Alex.',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.slate900,
                            fontWeight: FontWeight.w800, // extabold
                          ),
                    ),
                    const SizedBox(height: 8), // mb-2
                    Text(
                      "Você está a 8.500 XP de atingir o Nível 43. Complete seus objetivos diários para manter sua sequência.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.slate500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 24), // mb-6
                    const FounderStatsRowWidget(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FounderAvatarWidget extends StatelessWidget {
  const FounderAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128, // size-32
      height: 128,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24), // 3xl
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000), // shadow-2xl roughly
                  blurRadius: 50,
                  offset: Offset(0, 25),
                ),
              ],
              image: const DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDpkRPcaRpZCN4sY0oMEV_itFO1n9FKGMXOThNQA5Kxinicsv5zUq5HEL7UZkRk0gCs0CCRXVpdr6E5JoK3jagueIi_o-_aTJcg7dSGkQlTMsEXVR1aDg8ZzJaxJ5lBFnTBvfkRqiYUoy663otJuJe6nPdwrx17bbad3v6rIDWakoBiIK7hSkTuRia4r5B-prdvfzoi-240Up0rqgJkrTJa_vLdSZbPF1s0EbLucfxaXFbPHJB_yC_HQq037OP3bpozWitiiHJaV-Mr',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -8, // -bottom-2
            right: -8, // -right-2
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8), // lg
                border: Border.all(color: AppColors.white, width: 4),
              ),
              child: Text(
                'Lvl 42',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.slate900,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FounderStatsRowWidget extends StatelessWidget {
  const FounderStatsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FounderStatItemWidget(label: 'Total XP', value: '142,850'),
        FounderStatItemWidget(
          label: 'Sequência',
          value: '12 Dias',
          icon: Icons.local_fire_department,
          iconColor: Colors.orange,
          valueColor: Colors.orange,
        ),
        FounderStatItemWidget(label: 'Reputação', value: '9.8/10'),
        FounderStatItemWidget(label: 'Rank', value: 'Top 1%'),
      ],
    );
  }
}

class FounderStatItemWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final Color? valueColor;

  const FounderStatItemWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.slate400,
            fontWeight: FontWeight.w700,
            letterSpacing: 2, // tracking-widest
          ),
        ),
        const SizedBox(height: 4), // mb-1
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 4), // gap-1
            ],
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: valueColor ?? AppColors.slate900,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
