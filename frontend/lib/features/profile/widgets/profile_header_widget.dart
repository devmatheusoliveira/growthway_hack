import 'package:flutter/material.dart';
import 'package:frontend/shared/models/profile_model.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final ProfileModel profile;

  const ProfileHeaderWidget({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate900.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatarWidget(avatarUrl: profile.avatarUrl),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.fullName ?? 'Usuário sem nome',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.slate900,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 4),
                    _ProfileLevelBadge(level: profile.level),
                  ],
                ),
              ),
              _ProfileEditButton(onPressed: () {}),
            ],
          ),
          const SizedBox(height: 24),
          ProfileXPProgressWidget(
            xp: profile.xp,
            level: profile.level,
          ),
        ],
      ),
    );
  }
}

class ProfileAvatarWidget extends StatelessWidget {
  final String? avatarUrl;

  const ProfileAvatarWidget({super.key, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withAlpha(50),
          width: 4,
        ),
        image: avatarUrl != null
            ? DecorationImage(
                image: NetworkImage(avatarUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: avatarUrl == null
          ? const Center(
              child: Icon(
                Icons.person,
                size: 40,
                color: AppColors.slate400,
              ),
            )
          : null,
    );
  }
}

class _ProfileLevelBadge extends StatelessWidget {
  final int level;

  const _ProfileLevelBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        'Nível $level',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _ProfileEditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ProfileEditButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.slate100,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.edit_outlined,
          size: 20,
          color: AppColors.slate600,
        ),
      ),
    );
  }
}

class ProfileXPProgressWidget extends StatelessWidget {
  final int xp;
  final int level;

  const ProfileXPProgressWidget({
    super.key,
    required this.xp,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final int xpInCurrentLevel = xp % (level * 100);
    final int xpToNextLevel = level * 100;
    final double progress = xpInCurrentLevel / xpToNextLevel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Experiência',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.slate600,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '$xpInCurrentLevel / $xpToNextLevel XP',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.slate500,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Stack(
          children: [
            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withAlpha(200),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(80),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

