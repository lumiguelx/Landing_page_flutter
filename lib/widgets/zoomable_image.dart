import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dart:ui';

class ZoomableImage extends StatelessWidget {
  final String imagePath;
  final String? heroTag;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? errorWidget;

  const ZoomableImage({
    super.key,
    required this.imagePath,
    this.heroTag,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          imagePath,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? 
              Container(
                color: Colors.grey[200],
                child: const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              );
          },
        ),
      ),
    );

    return GestureDetector(
      onTap: () => _openZoomView(context),
      child: heroTag != null 
        ? Hero(
            tag: heroTag!,
            child: imageWidget,
          )
        : imageWidget,
    );
  }

  void _openZoomView(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fechar zoom',
      pageBuilder: (context, animation, secondaryAnimation) {
        return ZoomableImageViewer(
          imagePath: imagePath,
          heroTag: heroTag,
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
  }
}

class ZoomableImageViewer extends StatelessWidget {
  final String imagePath;
  final String? heroTag;

  const ZoomableImageViewer({
    super.key,
    required this.imagePath,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.3),
          child: Stack(
            children: [
              // Imagem centralizada com zoom
              Center(
                child: GestureDetector(
                  onTap: () {}, // Impede que o toque na imagem feche o zoom
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: heroTag != null
                      ? Hero(
                          tag: heroTag!,
                          child: _buildZoomableImage(),
                        )
                      : _buildZoomableImage(),
                  ),
                ),
              ),
              // Botão de fechar
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoomableImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: PhotoView(
        imageProvider: AssetImage(imagePath),
        backgroundDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3.0,
        initialScale: PhotoViewComputedScale.contained,
        heroAttributes: heroTag != null 
          ? PhotoViewHeroAttributes(tag: heroTag!)
          : null,
        loadingBuilder: (context, event) => Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

// Gallery version for multiple images
class ZoomableImageGallery extends StatelessWidget {
  final List<String> imagePaths;
  final int initialIndex;
  final List<String>? heroTags;

  const ZoomableImageGallery({
    super.key,
    required this.imagePaths,
    this.initialIndex = 0,
    this.heroTags,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.3),
          child: Stack(
            children: [
              // Galeria de imagens centralizada
              Center(
                child: GestureDetector(
                  onTap: () {}, // Impede que o toque na galeria feche
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.95,
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: PhotoViewGallery.builder(
                        itemCount: imagePaths.length,
                        pageController: PageController(initialPage: initialIndex),
                        builder: (context, index) {
                          final heroTag = heroTags?[index];
                          return PhotoViewGalleryPageOptions(
                            imageProvider: AssetImage(imagePaths[index]),
                            heroAttributes: heroTag != null 
                              ? PhotoViewHeroAttributes(tag: heroTag)
                              : null,
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 3.0,
                            initialScale: PhotoViewComputedScale.contained,
                          );
                        },
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        loadingBuilder: (context, event) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Indicador de página
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 60,
                left: 0,
                right: 0,
                child: IgnorePointer( // Impede que os indicadores fechem o zoom
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      imagePaths.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == initialIndex 
                            ? Colors.white 
                            : Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Botão de fechar
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}