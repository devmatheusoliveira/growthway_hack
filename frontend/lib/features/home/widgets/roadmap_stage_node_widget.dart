import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

enum StageNodeType { completed, active, locked }

class RoadmapStageNodeWidget extends StatefulWidget {
  final StageNodeType type;

  const RoadmapStageNodeWidget({
    super.key,
    required this.type,
  });

  @override
  State<RoadmapStageNodeWidget> createState() => _RoadmapStageNodeWidgetState();
}

class _RoadmapStageNodeWidgetState extends State<RoadmapStageNodeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseScaleAnim;
  late Animation<double> _pulseShadowAnim;
  late Animation<double> _pingScaleAnim;
  late Animation<double> _pingOpacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _pulseScaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _pulseShadowAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 15.0, end: 25.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 25.0, end: 15.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _pingScaleAnim = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5)),
    );
    _pingOpacityAnim = Tween<double>(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5)),
    );

    if (widget.type == StageNodeType.active) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(RoadmapStageNodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.type == StageNodeType.active && oldWidget.type != StageNodeType.active) {
      _controller.repeat();
    } else if (widget.type != StageNodeType.active) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == StageNodeType.locked) {
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.slate200,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 4),
        ),
        child: const Center(
          child: Icon(
            Icons.lock_outline,
            color: AppColors.slate400,
            size: 32,
          ),
        ),
      );
    }

    if (widget.type == StageNodeType.active) {
      return SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pingScaleAnim.value,
                  child: Opacity(
                    opacity: _pingOpacityAnim.value,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseScaleAnim.value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(102),
                          blurRadius: _pulseShadowAnim.value,
                          spreadRadius: 4,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.rocket_launch,
                        color: AppColors.white,
                        size: 36,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(76),
            blurRadius: 16,
          )
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.check,
          color: AppColors.white,
          size: 32,
        ),
      ),
    );
  }
}
