import 'package:flutter/material.dart';

class ParallaxBackground extends StatelessWidget {
  final String imagePath;
  final Widget child;
  final double parallaxFactor;

  const ParallaxBackground({
    super.key,
    required this.imagePath,
    required this.child,
    this.parallaxFactor = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) => true,
          child: Stack(
            children: [
              // Parallax background image
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(0, _getParallaxOffset(context)),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: constraints.maxHeight + 200, // Extra height for parallax
                  ),
                ),
              ),
              // Content
              child,
            ],
          ),
        );
      },
    );
  }

  double _getParallaxOffset(BuildContext context) {
    final scrollable = Scrollable.of(context);
    if (scrollable == null) return 0;

    final position = scrollable.position;
    final viewportHeight = position.viewportDimension;
    final scrollOffset = position.pixels;

    // Calculate parallax offset
    return scrollOffset * parallaxFactor;
  }
}

class SmoothParallaxBackground extends StatefulWidget {
  final String imagePath;
  final Widget child;
  final double parallaxFactor;

  const SmoothParallaxBackground({
    super.key,
    required this.imagePath,
    required this.child,
    this.parallaxFactor = 0.3,
  });

  @override
  State<SmoothParallaxBackground> createState() => _SmoothParallaxBackgroundState();
}

class _SmoothParallaxBackgroundState extends State<SmoothParallaxBackground> {
  double _parallaxOffset = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                _parallaxOffset = notification.metrics.pixels * widget.parallaxFactor;
              });
            }
            return true;
          },
          child: Container(
            height: constraints.maxHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Fixed parallax background
                Positioned(
                  left: 0,
                  right: 0,
                  top: -_parallaxOffset,
                  child: Container(
                    height: constraints.maxHeight + 300,
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                // Content overlay
                widget.child,
              ],
            ),
          ),
        );
      },
    );
  }
}