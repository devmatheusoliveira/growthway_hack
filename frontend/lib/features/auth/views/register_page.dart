import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:frontend/features/auth/widgets/register_hero_widget.dart';
import 'package:frontend/features/auth/widgets/register_form_widget.dart';
import 'package:frontend/features/auth/widgets/login_background_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 1024)
            const Expanded(
              child: Stack(
                children: [LoginBackgroundWidget(), RegisterHeroWidget()],
              ),
            ),

          Expanded(
            child: Container(
              color: AppColors.backgroundLight,
              child: const RegisterFormWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
