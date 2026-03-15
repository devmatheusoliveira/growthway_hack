import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class DiagnosticOptionCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const DiagnosticOptionCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<DiagnosticOptionCardWidget> createState() =>
      _DiagnosticOptionCardWidgetState();
}

class _DiagnosticOptionCardWidgetState
    extends State<DiagnosticOptionCardWidget> {
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              color: widget.isSelected || _isHovered
                  ? AppColors.primary
                  : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (widget.isSelected || _isHovered)
                BoxShadow(
                  color: AppColors.slate900.withAlpha(20),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                )
              else
                BoxShadow(
                  color: AppColors.slate900.withAlpha(5),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
            ],
          ),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: widget.isSelected || _isHovered
                                    ? AppColors.primary
                                    : AppColors.slate900,
                                fontWeight: FontWeight.w700,
                              ),
                          child: Text(widget.title),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.slate500,
                                height: 1.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: widget.isSelected || _isHovered ? 1.0 : 0.0,
                  child: Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
