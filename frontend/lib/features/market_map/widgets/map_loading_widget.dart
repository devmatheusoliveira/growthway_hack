import 'package:flutter/material.dart';
import 'package:frontend/shared/theme/app_colors.dart';

class MapLoadingWidget extends StatelessWidget {
  final String message;

  const MapLoadingWidget({
    super.key,
    this.message = 'Carregando dados do mapa...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.slate500,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Buscando dados do IBGE e analisando mercado',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.slate400),
          ),
        ],
      ),
    );
  }
}
