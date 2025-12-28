import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class PixelGrid extends StatefulWidget {
  final Color? backgroundColor;
  final Color pixelColor;
  final double pixelSize;
  final double pixelSpacing;
  final int pixelDeathFade;
  final int pixelBornFade;
  final int pixelMaxLife;
  final int pixelMinLife;
  final int pixelMaxOffLife;
  final int pixelMinOffLife;
  final bool glow;
  final double opacity;
  final bool ledEffect;

  const PixelGrid({
    super.key,
    this.backgroundColor,
    this.pixelColor = const Color(0xFF3B82F6),
    this.pixelSize = 3.0,
    this.pixelSpacing = 12.0,
    this.pixelDeathFade = 8,
    this.pixelBornFade = 30,
    this.pixelMaxLife = 200,
    this.pixelMinLife = 100,
    this.pixelMaxOffLife = 300,
    this.pixelMinOffLife = 150,
    this.glow = false,
    this.opacity = 0.6,
    this.ledEffect = true,
  });

  @override
  State<PixelGrid> createState() => _PixelGridState();
}

class _PixelGridState extends State<PixelGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<Pixel> pixels = [];
  int frameCount = 0;
  int cols = 0;
  int rows = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 80), // Faster for LED effect
      vsync: this,
    )..addListener(_updatePixels);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePixels();
      _animationController.repeat();
    });
  }

  void _initializePixels() {
    final size = MediaQuery.of(context).size;
    cols = (size.width / (widget.pixelSize + widget.pixelSpacing)).ceil();
    rows = (size.height / (widget.pixelSize + widget.pixelSpacing)).ceil();
    
    pixels.clear();
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        pixels.add(Pixel(
          xPos: x * (widget.pixelSize + widget.pixelSpacing),
          yPos: y * (widget.pixelSize + widget.pixelSpacing),
          pixelDeathFade: widget.pixelDeathFade,
          pixelBornFade: widget.pixelBornFade,
          pixelMaxLife: widget.pixelMaxLife,
          pixelMinLife: widget.pixelMinLife,
          pixelMaxOffLife: widget.pixelMaxOffLife,
          pixelMinOffLife: widget.pixelMinOffLife,
          ledEffect: widget.ledEffect,
        ));
      }
    }
  }

  void _updatePixels() {
    frameCount++;
    // Update every 2nd frame for LED effect
    if (frameCount % 2 == 0 && mounted) {
      setState(() {
        for (var pixel in pixels) {
          pixel.update();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: widget.opacity,
          child: CustomPaint(
            painter: PixelGridPainter(
              pixels: pixels,
              pixelColor: widget.pixelColor,
              pixelSize: widget.pixelSize,
              glow: widget.glow,
              ledEffect: widget.ledEffect,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class Pixel {
  double xPos;
  double yPos;
  double alpha;
  double maxAlpha;
  int life;
  int offLife;
  bool isLit;
  bool dying;
  int deathFade;
  int bornFade;
  final int pixelDeathFade;
  final int pixelBornFade;
  final int pixelMaxLife;
  final int pixelMinLife;
  final int pixelMaxOffLife;
  final int pixelMinOffLife;
  final bool ledEffect;
  final Random _random = Random();

  Pixel({
    required this.xPos,
    required this.yPos,
    required this.pixelDeathFade,
    required this.pixelBornFade,
    required this.pixelMaxLife,
    required this.pixelMinLife,
    required this.pixelMaxOffLife,
    required this.pixelMinOffLife,
    required this.ledEffect,
  }) : 
    alpha = 0,
    maxAlpha = _randomAlpha(),
    life = 0,
    offLife = 0,
    isLit = false,
    dying = false,
    deathFade = pixelDeathFade,
    bornFade = pixelBornFade {
    _randomizeSelf();
  }

  static double _randomAlpha() {
    final rand = Random().nextDouble() * 100;
    if (rand > 92) return 1.0;  // Bright LED
    if (rand > 85) return 0.7;  // Medium LED
    if (rand > 75) return 0.4;  // Dim LED
    return 0.0;  // Off
  }

  void _randomizeSelf() {
    final newAlpha = _randomAlpha();
    alpha = 0;
    maxAlpha = newAlpha;
    life = _random.nextInt(pixelMaxLife - pixelMinLife + 1) + pixelMinLife;
    offLife = _random.nextInt(pixelMaxOffLife - pixelMinOffLife + 1) + pixelMinOffLife;
    isLit = newAlpha > 0.0;
    dying = false;
    deathFade = pixelDeathFade;
    bornFade = pixelBornFade;
  }

  void update() {
    if (ledEffect) {
      // LED-style instant on/off with some flicker
      if (isLit) {
        if (life <= 0) {
          // Instant off like LED
          alpha = 0;
          isLit = false;
          _randomizeSelf();
        } else {
          // LED brightness with slight flicker
          alpha = maxAlpha * (0.8 + 0.2 * _random.nextDouble());
          life--;
        }
      } else {
        if (offLife <= 0) {
          // Instant on like LED
          isLit = true;
          alpha = maxAlpha;
        }
        offLife--;
      }
    } else {
      // Original smooth fade effect
      if (isLit) {
        if (bornFade <= 0) {
          if (life <= 0) {
            dying = true;
            if (deathFade <= 0) {
              _randomizeSelf();
            } else {
              alpha = (deathFade / pixelDeathFade) * maxAlpha;
              deathFade--;
            }
          } else {
            life--;
          }
        } else {
          alpha = maxAlpha * (1 - bornFade / pixelBornFade);
          bornFade--;
        }
      } else {
        if (offLife <= 0) {
          isLit = true;
        }
        offLife--;
      }
    }
  }
}

class PixelGridPainter extends CustomPainter {
  final List<Pixel> pixels;
  final Color pixelColor;
  final double pixelSize;
  final bool glow;
  final bool ledEffect;

  PixelGridPainter({
    required this.pixels,
    required this.pixelColor,
    required this.pixelSize,
    required this.glow,
    required this.ledEffect,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    if (glow && !ledEffect) {
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    }

    for (final pixel in pixels) {
      if (pixel.alpha > 0.05) {
        paint.color = pixelColor.withOpacity(pixel.alpha);
        
        if (ledEffect) {
          // LED-style square pixels
          final rect = Rect.fromLTWH(
            pixel.xPos, 
            pixel.yPos, 
            pixelSize, 
            pixelSize
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(pixelSize * 0.1)),
            paint,
          );
          
          // LED center highlight
          if (pixel.alpha > 0.5) {
            paint.color = Colors.white.withOpacity(pixel.alpha * 0.3);
            canvas.drawRRect(
              RRect.fromRectAndRadius(
                Rect.fromLTWH(
                  pixel.xPos + pixelSize * 0.3, 
                  pixel.yPos + pixelSize * 0.3, 
                  pixelSize * 0.4, 
                  pixelSize * 0.4
                ),
                Radius.circular(pixelSize * 0.05),
              ),
              paint,
            );
          }
        } else {
          // Original circle style
          canvas.drawCircle(
            Offset(pixel.xPos + pixelSize/2, pixel.yPos + pixelSize/2),
            pixelSize/2,
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}