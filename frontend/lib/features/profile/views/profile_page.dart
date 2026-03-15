import 'package:flutter/material.dart';
import 'package:frontend/features/profile/widgets/profile_header_widget.dart';
import 'package:frontend/features/profile/widgets/profile_info_section_widget.dart';
import 'package:frontend/features/profile/widgets/profile_startup_card_widget.dart';
import 'package:frontend/features/profile/widgets/profile_stats_grid_widget.dart';
import 'package:frontend/shared/models/profile_model.dart';
import 'package:frontend/shared/models/startup_model.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/widgets/sidebar_widget.dart';
import 'package:frontend/features/home/widgets/header_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fake data for demonstration
    const mockProfile = ProfileModel(
      id: '1',
      fullName: 'Matheus Oliveira',
      xp: 450,
      level: 5,
      avatarUrl: 'https://i.pravatar.cc/150?u=matheus',
    );

    const mockStartup = StartupModel(
      id: 's1',
      ownerId: '1',
      name: 'GrowthWay Tech',
      description: 'Plataforma de aceleração de startups utilizando IA.',
      logoUrl: 'https://logo.clearbit.com/growthway.io',
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Row(
        children: [
          const SidebarWidget(activeIndex: 4),
          Expanded(
            child: Column(
              children: [
                const HeaderWidget(
                  title: 'Meu Perfil',
                  icon: Icons.person_outline,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ProfileHeaderWidget(profile: mockProfile),
                          const SizedBox(height: 32),
                          const ProfileInfoSectionWidget(
                            title: 'Estatísticas',
                            child: ProfileStatsGridWidget(),
                          ),
                          const SizedBox(height: 32),
                          ProfileInfoSectionWidget(
                            title: 'Minhas Startups',
                            actionLabel: 'Adicionar',
                            onActionPressed: () {},
                            child: const ProfileStartupCardWidget(startup: mockStartup),
                          ),
                          const SizedBox(height: 32),
                          const ProfileInfoSectionWidget(
                            title: 'Sobre',
                            child: _ProfileAboutWidget(),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
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

class _ProfileAboutWidget extends StatelessWidget {
  const _ProfileAboutWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Text(
        'Empreendedor apaixonado por tecnologia e inovação. Buscando transformar o ecossistema de startups no Brasil através de soluções escaláveis e inteligência artificial.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.slate600,
              height: 1.6,
            ),
      ),
    );
  }
}
