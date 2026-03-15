import 'package:flutter/material.dart';
import 'package:frontend/shared/models/startup_model.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class ProfileStartupCardWidget extends StatelessWidget {
  final StartupModel startup;

  const ProfileStartupCardWidget({
    super.key,
    required this.startup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        children: [
          _StartupLogoWidget(logoUrl: startup.logoUrl),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  startup.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.slate900,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                if (startup.description != null)
                  Text(
                    startup.description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.slate500,
                        ),
                  ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.slate400,
          ),
        ],
      ),
    );
  }
}

class _StartupLogoWidget extends StatelessWidget {
  final String? logoUrl;

  const _StartupLogoWidget({this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.slate100,
        borderRadius: BorderRadius.circular(12),
        image: logoUrl != null
            ? DecorationImage(
                image: NetworkImage(logoUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: logoUrl == null
          ? const Icon(
              Icons.business,
              color: AppColors.slate400,
            )
          : null,
    );
  }
}
