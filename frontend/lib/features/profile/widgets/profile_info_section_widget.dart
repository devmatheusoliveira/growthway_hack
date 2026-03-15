import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class ProfileInfoSectionWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  const ProfileInfoSectionWidget({
    super.key,
    required this.title,
    required this.child,
    this.onActionPressed,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.slate900,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            if (onActionPressed != null && actionLabel != null)
              TextButton(
                onPressed: onActionPressed,
                child: Text(
                  actionLabel!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
