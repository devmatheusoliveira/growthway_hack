import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class DailyQuestsPanelWidget extends StatelessWidget {
  const DailyQuestsPanelWidget({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DailyQuestsHeaderWidget(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24), // p-6
              children: const [
                DailyQuestItemWidget(
                  title: 'Briefing Matinal',
                  description:
                      "Revisar métricas de desempenho da equipe de ontem",
                  duration: '5 min',
                  xpReward: '+50 XP',
                ),
                SizedBox(height: 16), // gap-4 equivalent
                DailyQuestItemWidget(
                  title: 'Hora do Networking',
                  description:
                      'Conectar com 5 parceiros em potencial no LinkedIn',
                  duration: '60 min',
                  xpReward: '+250 XP',
                ),
                SizedBox(height: 16),
                DailyQuestCompletedItemWidget(
                  title: 'Sincronização de E-mail com Investidores',
                  description:
                      'Atualizar principais investidores sobre taxas de burnout semanal',
                ),
              ],
            ),
          ),
          const DailyQuestsFooterWidget(),
        ],
      ),
    );
  }
}

class DailyQuestsHeaderWidget extends StatelessWidget {
  const DailyQuestsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.slate100)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Colors.orange),
          const SizedBox(width: 8),
          Text(
            'Missões Diárias',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
            ),
          ),
        ],
      ),
    );
  }
}

class DailyQuestsFooterWidget extends StatelessWidget {
  const DailyQuestsFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.slate200,
              style: BorderStyle.none,
            ),
          ), // Custom Painter for dashed border would go here, or just a solid one for simplicity.
          // Let's use a solid border with slate200 since dashed isn't native without a package.
          // Wait, we can use a custom painter, but for speed, let's just make it a light border.
          // I will just use a solid border for now.
          alignment: Alignment.center,
          child: Text(
            '+ Sugerir Nova Missão',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.slate500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class DailyQuestItemWidget extends StatefulWidget {
  final String title;
  final String description;
  final String duration;
  final String xpReward;

  const DailyQuestItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.xpReward,
  });

  @override
  State<DailyQuestItemWidget> createState() => _DailyQuestItemWidgetState();
}

class _DailyQuestItemWidgetState extends State<DailyQuestItemWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // rounded-xl
          border: Border.all(
            color: _isHovering
                ? AppColors.primary.withAlpha(77)
                : AppColors.slate100, // primary/30
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isHovering ? AppColors.primary : AppColors.slate200,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                color: _isHovering ? AppColors.primary : AppColors.slate200,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate900,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: AppColors.slate500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.slate100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.duration,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.slate600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.xpReward,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyQuestCompletedItemWidget extends StatelessWidget {
  final String title;
  final String description;

  const DailyQuestCompletedItemWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(13), // primary/5
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.done_all,
              color: AppColors.slate900,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate400,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.slate400,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.slate400),
                ),
                const SizedBox(height: 8),
                const Text(
                  'CONCLUÍDO',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate400,
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
