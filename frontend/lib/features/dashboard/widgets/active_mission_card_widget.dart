import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class ActiveMissionCardWidget extends StatelessWidget {
  const ActiveMissionCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ActiveMissionHeaderWidget(),
          ActiveMissionProgressWidget(),
          ActiveMissionRewardsWidget(),
        ],
      ),
    );
  }
}

class ActiveMissionHeaderWidget extends StatelessWidget {
  const ActiveMissionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.slate100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(51), // primary/20
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.flag, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Missão Ativa: Expansão de Mercado',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate900,
                    ),
                  ),
                  Text(
                    'Objetivo: Adquirir 1.000 usuários beta ativos',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: AppColors.slate500),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Ver Todas as Missões',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveMissionProgressWidget extends StatelessWidget {
  const ActiveMissionProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progresso',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate900,
                ),
              ),
              Text(
                '65%',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900, // black
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 24, // h-6
            width: double.infinity,
            padding: const EdgeInsets.all(4), // p-1
            decoration: BoxDecoration(
              color: AppColors.slate100,
              borderRadius: BorderRadius.circular(9999), // full
            ),
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: constraints.maxWidth * 0.65,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withAlpha(128),
                            blurRadius:
                                15, // shadow-[0_0_15px_rgba(107,200,14,0.5)]
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ActiveMissionAvatarsWidget(),
              Text(
                '350 usuários restantes para completar o objetivo',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.slate500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActiveMissionAvatarsWidget extends StatelessWidget {
  const ActiveMissionAvatarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 32,
      width: 104, // 32 + 24 + 24 + 24
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AvatarItemWidget(
            index: 0,
            url:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCZ2EoEFv8guk6zGUEJJWmUeCjtI3Z8lal6LctaH8E9W6tPD8NwTI5hBpXPRFNS9C45rhEz95Ksq2cRAulTvyTG5USj3blHGdL3DOZak7ib7vRhhrRTvl-8RufzXP2iDXXbB3VukNDW981LFV6QGe-jSI22di_uvqyfb5wM0MYBCjCiN_vLo3l_FaOoFVKqRDqQiX69tQsXnJWiFRbOOnp8ltWuB6rVEQM8YJ_unYEhphl37GeDTXsIQNKZXC151DbcMW4pHwhzGgGi',
          ),
          AvatarItemWidget(
            index: 1,
            url:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDvSSyE76Hiw2UZOOoETgtgRzMODFFpK6MHH4iIsgz6uHvFoIz0F2WCmLqDQ3IFL2-MfET5898LjXYgZoQ8e_ldVBiGNEh9DUozQOQOJWzE0i4Mr3J4QoFMomppQmINC-ydFFRI9IMECN2_IsB-XhHoqteMgQUaRa_JGpjq71-49uJQCfJ5J_IQ0RgxvCcwH_7ykEnDEi0PATVXspFzwNJ-cxjQS-LB0aeO8dvIP8gN7N8Xd-rXurntZZvzItsfdPDlCtaOVzeCRckt',
          ),
          AvatarItemWidget(
            index: 2,
            url:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBAlMLQS2iNgkCqnagtOVWQc32tapPKUfvROdOI4QT_q4RtRm7NHZx_85v2B3p_ufDW4hNuK-Rh6dGWKrafyMnLazjd1fxmr6LwFgp3Akq4r2j3RTCYtNxi2u0scuhfZhQcwBpbvy1Wwz-BHaAybazxurZCkTQI3ku2aCNr87vFzTL3d5Q0EV9OcMy6GPVIsKHYvCyFymz0JS0MJ2MV_-KFwWVzZAOguRgLG4d8AHQ8bXmqH2Kuu_MmHA42xwOPetEEPPerJlOibu0c',
          ),
          PlusAvatarItemWidget(index: 3, text: '+5'),
        ],
      ),
    );
  }
}

class AvatarItemWidget extends StatelessWidget {
  final int index;
  final String url;

  const AvatarItemWidget({super.key, required this.index, required this.url});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: index * 24.0, // 32 - 8 (overlapping)
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class PlusAvatarItemWidget extends StatelessWidget {
  final int index;
  final String text;

  const PlusAvatarItemWidget({
    super.key,
    required this.index,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: index * 24.0,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.slate100,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.slate900,
          ),
        ),
      ),
    );
  }
}

class ActiveMissionRewardsWidget extends StatelessWidget {
  const ActiveMissionRewardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppColors.slate50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recompensas ao completar',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: AppColors.slate500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.stars,
                            color: AppColors.primary,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '+5,000 XP',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.workspace_premium,
                            color: Colors.orange,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Emblema 'Expansionista'",
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.slate900,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Lançar Fase 2',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
