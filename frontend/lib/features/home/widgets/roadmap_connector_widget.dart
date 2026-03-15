import 'package:flutter/material.dart';

class RoadmapConnectorWidget extends StatelessWidget {
  final bool isSolid;
  final bool isHalf;
  final bool isEnd;

  const RoadmapConnectorWidget({
    super.key,
    this.isSolid = false,
    this.isHalf = false,
    this.isEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isEnd) {
      return Container(
        width: 8,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.transparent, // to force column layout 
        ),
        child: Column(
          children: [
            Expanded(child: Container(color: const Color(0xFFE2E8F0))),
            Container(
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFE2E8F0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (isHalf) {
      return SizedBox(
        width: 8,
        height: 80,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6BC80E),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xFFE2E8F0),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 8,
      height: 80,
      decoration: BoxDecoration(
        color: isSolid ? const Color(0xFF6BC80E) : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
