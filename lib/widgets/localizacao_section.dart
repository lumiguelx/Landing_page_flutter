import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'section_header.dart';

class LocalizacaoSection extends StatelessWidget {
  const LocalizacaoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppColors.grayLight,
      child: Column(
        children: [
          const SectionHeader(
            title: 'Localização',
            subtitle: 'Venha nos visitar!',
          ),
          const SizedBox(height: 40),
          Container(
            height: 300,
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 64,
                    color: AppColors.redAccent,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Super Yama',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Teixeira, PB',
                    style: TextStyle(
                      color: AppColors.grayDark.withValues(alpha: 0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Adicione o mapa aqui',
                    style: TextStyle(
                      color: AppColors.grayDark.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
