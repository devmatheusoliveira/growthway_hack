import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/features/auth/widgets/login_hero_widget.dart';
import 'package:frontend/features/auth/widgets/login_form_widget.dart';
import 'package:frontend/features/auth/widgets/login_background_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Row(
        children: [
          // Left Side (Hero) - Visible only on Desktop/Large screens
          if (MediaQuery.of(context).size.width >= 1024)
            const Expanded(
              child: Stack(
                children: [LoginBackgroundWidget(), LoginHeroWidget()],
              ),
            ),

          // Right Side (Form) with white background
          Expanded(
            child: Container(
              color: AppColors.backgroundLight,
              child: const LoginFormWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
