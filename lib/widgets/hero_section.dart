import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'pixel_grid.dart';
import 'parallax_background.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: SmoothParallaxBackground(
        imagePath: 'assets/images/paralax1K.jpg',
        parallaxFactor: 0.3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Pixel Grid Overlay - LED Matrix effect
            PixelGrid(
              pixelColor: const Color(0xFF00BFFF), // Azul LED vibrante
              pixelSize: 4.0,
              pixelSpacing: 8.0,
              opacity: 0.7,
              glow: false,
              ledEffect: true,
              pixelMaxLife: 120,
              pixelMinLife: 60,
              pixelMaxOffLife: 180,
              pixelMinOffLife: 90,
            ),
            // Overlay sutil para não interferir com LEDs
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.2),
                  ],
                ),
              ),
            ),
            // Logo e conteúdo
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo do Super Yama
                    Container(
                      width: 200,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SUPER',
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 4,
                              color: AppColors.redAccent,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                            ),
                            Text(
                              'YAMA',
                              style: TextStyle(
                                color: AppColors.redAccent,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'SUPERMERCADO',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black54,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Qualidade e tradição em cada compra',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.black45,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redAccent,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                      ),
                      child: const Text(
                        'Ver Ofertas',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}