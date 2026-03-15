import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/features/auth/widgets/gamification_card_widget.dart';

class LoginHeroWidget extends StatelessWidget {
  const LoginHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.rocket_launch,
                  color: AppColors.backgroundDark,
                  size: 32,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'StartupHub',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          // Key Copy + Card
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(51),
                  border: Border.all(color: AppColors.primary.withAlpha(76)),
                  borderRadius: BorderRadius.circular(999),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Level Up Your Business'.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Sua jornada\n',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                  children: [
                    TextSpan(
                      text: 'épica',
                      style: TextStyle(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary.withAlpha(76),
                      ),
                    ),
                    const TextSpan(text: ' começa\nagora.'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Transforme sua ideia em um unicórnio enquanto\ndesbloqueia conquistas, ganha XP e domina o mercado.',
                style: TextStyle(
                  color: AppColors.slate400,
                  fontSize: 18,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),
              const GamificationCardWidget(),
            ],
          ),

          // Footer
          Row(
            children: [
              const Text(
                '© 2024 StartupHub Inc.',
                style: TextStyle(
                  color: AppColors.slate500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 24),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Termos',
                  style: TextStyle(
                    color: AppColors.slate500,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Privacidade',
                  style: TextStyle(
                    color: AppColors.slate500,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
