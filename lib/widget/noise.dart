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

  @override
  void initState() {
    noiseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        print(noiseAnimationController!.value);
        setState(() {
          noiseLevel = noiseAnimationController!.value;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          painter: NoisePainter(
            Size(constraints.maxWidth, constraints.maxHeight),
            noiseLevel,
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
    const blockSize = 1;
    final random = Random();

    // 画面をブロックサイズで分割して、ブロックごとにランダムに塗りつぶす
    for (var width = 0; width < maxSize.width ~/ blockSize + 1; width++) {
      for (var height = 0; height < maxSize.height ~/ blockSize + 1; height++) {
        final x = width * blockSize;
        final y = height * blockSize;

        final rand = random.nextDouble();
        // 閾値チェック
        if (rand < noiseLevel) {
          final paint = Paint()
            ..color = Color(0xFF000000 + random.nextInt(0xFFFFFF))
            ..style = PaintingStyle.fill;

          canvas.drawRect(
            Rect.fromLTWH(
              x.toDouble(),
              y.toDouble(),
              blockSize.toDouble(),
              blockSize.toDouble(),
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
