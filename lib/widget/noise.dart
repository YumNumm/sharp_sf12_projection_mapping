import 'dart:math';

import 'package:flutter/material.dart';

AnimationController? noiseAnimationController;

class NoiseWidget extends StatefulWidget {
  const NoiseWidget({super.key});

  @override
  State<NoiseWidget> createState() => _NoiseWidgetState();
}

class _NoiseWidgetState extends State<NoiseWidget>
    with TickerProviderStateMixin {
  double noiseLevel = 0;
  double backgroundOpacity = 0;

  int counter = 0;

  bool isProcessing = false;

  @override
  void initState() {
    noiseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        counter++;
        setState(() {
          if (counter % 10 == 0) {
            noiseLevel = noiseAnimationController!.value;
            counter = 0;
          }
          if (noiseAnimationController!.value == 0) {
            noiseLevel = 0;
          }
          if (noiseAnimationController!.value == 1) {
            noiseLevel = 1;
          }
          backgroundOpacity =
              pow(noiseAnimationController!.value, 4).toDouble();
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(backgroundOpacity),
            ),
            child: RepaintBoundary(
              child: CustomPaint(
                painter: NoisePainter(
                  Size(constraints.maxWidth, constraints.maxHeight),
                  noiseLevel,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NoisePainter extends CustomPainter {
  NoisePainter(this.maxSize, this.noiseLevel);

  /// ノイズレベル　0.0 ~ 1.0
  final double noiseLevel;
  final Size maxSize;

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();

    // 画面をブロックサイズで分割して、ブロックごとにランダムに塗りつぶす

    // 閾値チェック
    for (var i = 0; i < pow(noiseLevel, 3) * 40; i++) {
      final x = random.nextInt(maxSize.width.toInt());
      final y = random.nextInt(maxSize.height.toInt());
      final paint = Paint()
        ..color = const Color(0xFF000000)
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromLTWH(
          x.toDouble(),
          y.toDouble(),
          (random.nextInt(maxSize.width ~/ 10) + 10).toDouble(),
          (random.nextInt(maxSize.height ~/ 10) + 20).toDouble(),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant NoisePainter oldDelegate) {
    return oldDelegate.maxSize != maxSize ||
        oldDelegate.noiseLevel != noiseLevel;
  }
}
