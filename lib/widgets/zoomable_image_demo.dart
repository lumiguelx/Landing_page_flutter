import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'zoomable_image.dart';
import 'dart:ui';

class ZoomableImageDemo extends StatelessWidget {
  const ZoomableImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoomable Image Demo'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Zoomable Images Demo',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tap on any image to open it in full-screen zoom mode. You can pinch to zoom, pan to move around, and tap the close button or background to exit.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkGray,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            
            // Single images grid
            Text(
              'Individual Images',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    children: [
                      Expanded(
                        child: _buildImageCard(
                          'Jornal Frente',
                          'assets/images/frente.jpeg',
                          'frente_demo',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildImageCard(
                          'Jornal Verso',
                          'assets/images/verso.jpeg',
                          'verso_demo',
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    _buildImageCard(
                      'Jornal Frente',
                      'assets/images/frente.jpeg',
                      'demo_frente_individual',
                    ),
                    const SizedBox(height: 16),
                    _buildImageCard(
                      'Jornal Verso',
                      'assets/images/verso.jpeg',
                      'demo_verso_individual',
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // Gallery button
            Text(
              'Gallery View',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Open both images in a swipeable gallery:',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.darkGray,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: 'Fechar galeria',
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const ZoomableImageGallery(
                        imagePaths: [
                          'assets/images/frente.jpeg',
                          'assets/images/verso.jpeg',
                        ],
                        initialIndex: 0,
                        heroTags: ['demo_frente_gallery', 'demo_verso_gallery'],
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
                icon: const Icon(Icons.photo_library),
                label: const Text('Open Gallery'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redAccent,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String title, String imagePath, String heroTag) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZoomableImage(
            imagePath: imagePath,
            heroTag: heroTag,
            height: 200,
            width: double.infinity,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            errorWidget: Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 48,
                      color: AppColors.primaryBlue.withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}