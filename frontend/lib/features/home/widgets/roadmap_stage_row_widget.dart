import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/features/home/widgets/roadmap_stage_node_widget.dart';

enum StageDirection { left, right, centerExpanded, leftLocked }

class RoadmapStageRowWidget extends StatelessWidget {
  final StageDirection direction;
  final Widget childCard;

  const RoadmapStageRowWidget({
    super.key,
    required this.direction,
    required this.childCard,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == StageDirection.centerExpanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RoadmapStageNodeWidget(type: StageNodeType.active),
          const SizedBox(height: 32),
          childCard,
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child:
              direction == StageDirection.left ||
                  direction == StageDirection.leftLocked
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    childCard,
                    Container(
                      width: 64,
                      height: 6,
                      color: direction == StageDirection.leftLocked
                          ? AppColors.slate200
                          : AppColors.primary.withAlpha(51),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
        RoadmapStageNodeWidget(
          type: direction == StageDirection.leftLocked
              ? StageNodeType.locked
              : StageNodeType.completed,
        ),
        Expanded(
          child: direction == StageDirection.right
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 6,
                      color: AppColors.primary.withAlpha(51),
                    ),
                    childCard,
                  ],
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
