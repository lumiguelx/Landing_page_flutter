import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'section_header.dart';

class GaleriaSection extends StatelessWidget {
  const GaleriaSection({super.key});

  // Lista de imagens disponíveis
  static const List<String> _images = [
    'assets/images/paralax1K.jpg',
    'assets/images/paralax1.jpg',
    'assets/images/2024-08-05.webp',
    'assets/images/2024-08-05 (1).webp',
    'assets/images/feature.png',
    'assets/images/paralax1K.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppColors.grayLight,
      child: Column(
        children: [
          const SectionHeader(
            title: 'Galeria',
            subtitle: 'Conheça nosso mercado',
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 350,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
            ),
            itemCount: _images.length,
            itemBuilder: (context, index) => _buildGaleriaItem(_images[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildGaleriaItem(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.lightBlue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 48,
                      color: AppColors.primaryBlue.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Foto',
                      style: TextStyle(
                        color: AppColors.primaryBlue.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
