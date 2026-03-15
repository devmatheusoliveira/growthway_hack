import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class SidebarNavItemWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const SidebarNavItemWidget({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  State<SidebarNavItemWidget> createState() => _SidebarNavItemWidgetState();
}

class _SidebarNavItemWidgetState extends State<SidebarNavItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.primary.withAlpha(25)
                : (_isHovered ? AppColors.slate100 : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.isActive ? AppColors.primary : AppColors.slate600,
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: widget.isActive
                      ? AppColors.primary
                      : AppColors.slate600,
                  fontWeight: widget.isActive
                      ? FontWeight.w700
                      : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
