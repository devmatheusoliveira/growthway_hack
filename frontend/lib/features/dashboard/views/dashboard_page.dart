import 'package:flutter/material.dart';
import 'package:frontend/features/dashboard/widgets/active_mission_card_widget.dart';
import 'package:frontend/features/dashboard/widgets/daily_quests_panel_widget.dart';
import 'package:frontend/features/dashboard/widgets/founder_hero_widget.dart';
import 'package:frontend/features/dashboard/widgets/team_dynamics_widget.dart';
import 'package:frontend/features/home/widgets/header_widget.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/widgets/sidebar_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Row(
        children: [
          const SidebarWidget(activeIndex: 0),
          Expanded(
            child: Column(
              children: [
                const HeaderWidget(title: 'Dashboard', icon: Icons.dashboard),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(32),
                    children: [
                      const FounderHeroWidget(),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 480,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Expanded(flex: 8, child: ActiveMissionCardWidget()),
                            SizedBox(width: 32),
                            Expanded(flex: 4, child: DailyQuestsPanelWidget()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const TeamDynamicsWidget(),
                    ],
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
