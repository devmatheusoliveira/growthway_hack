import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class LoginBackgroundWidget extends StatelessWidget {
  const LoginBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Glow Tops
        Positioned(
          top: -150,
          left: -150,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withAlpha(51),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -150,
          right: -150,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withAlpha(26),
              ),
            ),
          ),
        ),

        // Floating 3D-like Element (Neon shape)
        Positioned(
          right: -100,
          top: MediaQuery.of(context).size.height * 0.15,
          child: Opacity(
            opacity: 0.15,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: CustomPaint(
                size: const Size(400, 400),
                painter: NeonBlobPainter(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NeonBlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.5, size.height * 0.2)
      ..cubicTo(
        size.width * 0.8,
        size.height * 0.1,
        size.width * 0.9,
        size.height * 0.4,
        size.width * 0.7,
        size.height * 0.6,
      )
      ..cubicTo(
        size.width * 0.5,
        size.height * 0.8,
        size.width * 0.2,
        size.height * 0.7,
        size.width * 0.3,
        size.height * 0.4,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
