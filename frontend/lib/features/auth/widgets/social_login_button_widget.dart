import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class SocialLoginButtonWidget extends StatelessWidget {
  final String label;
  final String iconUrl;
  final VoidCallback onTap;

  const SocialLoginButtonWidget({
    super.key,
    required this.label,
    required this.iconUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.slate200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(iconUrl, width: 20, height: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.slate900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
