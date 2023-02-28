import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.viewmodel.dart';
import 'package:sharp_sf12_projection_mapping/widget/shadow_overlay_viewmodel.dart';

AnimationController? noiseAnimationController;

class NoiseWidget extends ConsumerStatefulWidget {
  const NoiseWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoiseWidgetState();
}

class _NoiseWidgetState extends ConsumerState<NoiseWidget>
    with TickerProviderStateMixin {
  /// ノイズの強さ
  double noiseLevel = 0;

  /// 再描画回数制御用のカウンター
  int _counter = 0;

  /// 文字を光らせる間隔調節用
  /// 最後に文字を光らせた時間
  DateTime _lastTime = DateTime.now();

  @override
  void initState() {
    noiseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        _counter++;
        if (DateTime.now().difference(_lastTime).inMilliseconds > 200) {
          // ランダムに文字を光らせる
          ref
              .read(actViewStateProvider.notifier)
              .randomPress(Random().nextInt(12));
          _lastTime = DateTime.now();
        }
        ref.read(shadowOverlayStateProvider.notifier).state =
            pow(noiseAnimationController!.value, 4).toDouble();

        setState(() {
          if (_counter % 10 == 0) {
            noiseLevel = noiseAnimationController!.value;
          }
          if (noiseAnimationController!.status == AnimationStatus.completed) {
            noiseLevel = 0;
            ref.read(actViewStateProvider.notifier)
              ..setAnimationDuration(const Duration(milliseconds: 250))
              ..setAnimationPersistance(const Duration(milliseconds: 600));
          }
        });

        if (noiseAnimationController!.value == 1 ||
            noiseAnimationController!.value == 0) {
          ref.read(actViewStateProvider.notifier)
            ..randomPress(12)
            ..setAnimationDuration(const Duration(milliseconds: 80))
            ..setAnimationPersistance(const Duration(milliseconds: 200));
          setState(() {
            noiseLevel = 0;
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(noiseLevel);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _NoisePainter(
                Size(constraints.maxWidth, constraints.maxHeight),
                noiseLevel,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NoisePainter extends CustomPainter {
  _NoisePainter(this.maxSize, this.noiseLevel);

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
  bool shouldRepaint(covariant _NoisePainter oldDelegate) {
    return oldDelegate.maxSize != maxSize ||
        oldDelegate.noiseLevel != noiseLevel;
  }
}
