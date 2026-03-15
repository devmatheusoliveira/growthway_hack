import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/features/talent_network/models/talent_profile_model.dart';

class TalentProfileCardWidget extends StatefulWidget {
  final TalentProfileModel talent;
  final VoidCallback onViewProfile;

  const TalentProfileCardWidget({
    super.key,
    required this.talent,
    required this.onViewProfile,
  });

  @override
  State<TalentProfileCardWidget> createState() =>
      _TalentProfileCardWidgetState();
}

class _TalentProfileCardWidgetState extends State<TalentProfileCardWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? AppColors.primary.withAlpha(76) : AppColors.slate200,
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withAlpha(30)
                  : Colors.black.withAlpha(8),
              blurRadius: _isHovered ? 24 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TalentCardHeader(talent: widget.talent),
              const SizedBox(height: 12),
              Text(
                widget.talent.bio,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.slate500,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              _TalentSkillChips(skills: widget.talent.skills),
              const SizedBox(height: 16),
              const Divider(color: AppColors.slate100),
              const SizedBox(height: 12),
              _TalentCardFooter(
                talent: widget.talent,
                onViewProfile: widget.onViewProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TalentCardHeader extends StatelessWidget {
  final TalentProfileModel talent;

  const _TalentCardHeader({required this.talent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TalentAvatarWidget(initials: talent.avatarInitials),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                talent.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                talent.role,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        _RatingBadge(rating: talent.rating),
      ],
    );
  }
}

class _TalentAvatarWidget extends StatelessWidget {
  final String initials;

  const _TalentAvatarWidget({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(51),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;

  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.warning.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: AppColors.warning, size: 14),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: AppColors.warning,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _TalentSkillChips extends StatelessWidget {
  final List<String> skills;

  const _TalentSkillChips({required this.skills});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: skills
          .take(4)
          .map((skill) => _SkillChip(label: skill))
          .toList(),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;

  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withAlpha(40)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TalentCardFooter extends StatelessWidget {
  final TalentProfileModel talent;
  final VoidCallback onViewProfile;

  const _TalentCardFooter({
    required this.talent,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 14,
              color: AppColors.success,
            ),
            const SizedBox(width: 4),
            Text(
              '${talent.completedProjects} projetos',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.slate500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: onViewProfile,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: AppColors.primary),
            ),
          ),
          child: const Text(
            'Ver Perfil',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
