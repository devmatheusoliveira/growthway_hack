import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const HeaderWidget({
    super.key,
    this.title = 'Roadmap - Jornada Startup',
    this.icon = Icons.map_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 28),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.slate900,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 256, // w-64
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.slate100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: AppColors.slate400),
                    hintText: 'Buscar marcos...',
                    hintStyle: TextStyle(
                      color: AppColors.slate400,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.slate100),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.hovered)) {
                      return AppColors.primary;
                    }
                    return AppColors.slate600;
                  }),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all(const Size(44, 44)),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDE_237KNzWF1QMP6JQ1UsSGpk6mHk5ikW8gVHWwF4Uptvum5WktrJzQUFb4oljQ5Q8aHE2cEocUiWUxN-yc3RsNaq_AXZM29sdCZy-NXiaT3Shx7eDpdA7zalhOVlB35ZqR3w4AlHgJtYCmkyzUaJyBWhnq7ckk9vkstAgpFnoct3PIWsv6gD4szwlFskKkcASJrZxXtE9sTlRNzEavI28vnxKs7qBf2pnC93hacP2icJJrlsfaRK-EW9QX1ItIEEH8LNljhTrtz71',
                    ),
                    fit: BoxFit.cover,
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
