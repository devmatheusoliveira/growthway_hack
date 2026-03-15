import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/shared/widgets/sidebar_nav_item_widget.dart';
import 'package:frontend/shared/routes/app_routes.dart';

class SidebarWidget extends StatelessWidget {
  final int activeIndex;

  const SidebarWidget({super.key, this.activeIndex = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288, // 72 em Tailwind
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(right: BorderSide(color: AppColors.slate200)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(51),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.rocket_launch, // material-symbols: rocket_launch
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jornada Startup',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate900,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Modo Crescimento',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                SidebarNavItemWidget(
                  label: 'Dashboard',
                  icon: Icons.grid_view,
                  isActive: activeIndex == 0,
                  onTap: () {
                    if (activeIndex != 0) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.dashboard,
                      );
                    }
                  },
                ),
                const SizedBox(height: 4),
                SidebarNavItemWidget(
                  label: 'Roadmap',
                  icon: Icons.route,
                  isActive: activeIndex == 1,
                  onTap: () {
                    if (activeIndex != 1) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.roadmap,
                      );
                    }
                  },
                ),
                const SizedBox(height: 4),
                SidebarNavItemWidget(
                  label: 'Mapa de Mercado',
                  icon: Icons.map_outlined,
                  isActive: activeIndex == 2,
                  onTap: () {
                    if (activeIndex != 2) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.marketMap,
                      );
                    }
                  },
                ),
                const SizedBox(height: 4),
                SidebarNavItemWidget(
                  label: 'Diagnóstico',
                  icon: Icons.analytics_outlined,
                  isActive: activeIndex == 3,
                  onTap: () {
                    if (activeIndex != 3) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.diagnostic,
                      );
                    }
                  },
                ),
                const SizedBox(height: 4),
                SidebarNavItemWidget(
                  label: 'Perfil',
                  icon: Icons.person_outline,
                  isActive: activeIndex == 4,
                  onTap: () {
                    if (activeIndex != 4) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.profile,
                      );
                    }
                  },
                ),
                const SizedBox(height: 4),
                SidebarNavItemWidget(
                  label: 'Rede de Talentos',
                  icon: Icons.group_outlined,
                  isActive: activeIndex == 5,
                  onTap: () {
                    if (activeIndex != 5) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.talentNetwork,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.slate100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'NÍVEL 12',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.slate500,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                          ),
                          Text(
                            '2,450 XP',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.slate200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.65,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(127),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.hovered)) {
                        return AppColors.primary.withAlpha(230);
                      }
                      return AppColors.primary;
                    }),
                    foregroundColor: WidgetStateProperty.all(AppColors.white),
                    elevation: WidgetStateProperty.all(5),
                    shadowColor: WidgetStateProperty.all(
                      AppColors.primary.withAlpha(127),
                    ),
                    minimumSize: WidgetStateProperty.all(
                      const Size(double.infinity, 48),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Novo Projeto',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
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
