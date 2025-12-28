import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'section_header.dart';
import 'zoomable_image.dart';
import 'dart:ui';

class JornalSection extends StatelessWidget {
  const JornalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: AppColors.white,
      child: Column(
        children: [
          const SectionHeader(
            title: 'Jornal da Semana',
            subtitle: 'Confira as ofertas e promoções desta semana',
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildJornalCard('Frente', 'assets/images/frente.jpeg', context),
                    const SizedBox(width: 40),
                    _buildJornalCard('Verso', 'assets/images/verso.jpeg', context),
                  ],
                );
              }
              return Column(
                children: [
                  _buildJornalCard('Frente', 'assets/images/frente.jpeg', context),
                  const SizedBox(height: 30),
                  _buildJornalCard('Verso', 'assets/images/verso.jpeg', context),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildJornalCard(String label, String imagePath, BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          ZoomableImage(
            imagePath: imagePath,
            heroTag: null, // Disable hero animation to avoid conflicts
            width: double.infinity,
            height: 400,
            borderRadius: BorderRadius.circular(15),
            errorWidget: Container(
              color: AppColors.lightBlue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.newspaper,
                      size: 60,
                      color: AppColors.primaryBlue.withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      label,
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Abrir galeria com ambas as imagens
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: 'Fechar galeria',
                pageBuilder: (context, animation, secondaryAnimation) {
                  return ZoomableImageGallery(
                    imagePaths: const [
                      'assets/images/frente.jpeg',
                      'assets/images/verso.jpeg',
                    ],
                    initialIndex: label == 'Frente' ? 0 : 1,
                    heroTags: null, // Disable hero animations
                  );
                },
                transitionBuilder: (context, animation, secondaryAnimation, child) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10.0 * animation.value,
                      sigmaY: 10.0 * animation.value,
                    ),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.redAccent,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 5,
            ),
            child: Text(
              'Ver $label Completa',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}