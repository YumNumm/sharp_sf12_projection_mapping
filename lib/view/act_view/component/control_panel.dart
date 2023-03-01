import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sharp_sf12_projection_mapping/main.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.viewmodel.dart';
import 'package:sharp_sf12_projection_mapping/view/main_view/main_view.dart';
import 'package:sharp_sf12_projection_mapping/widget/shadow_overlay_viewmodel.dart';

import 'noise_widget.dart';

class ControlPanel extends ConsumerWidget {
  const ControlPanel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.of(navigatorKey.currentContext!).pushReplacement(
              MaterialPageRoute<void>(
                builder: (context) => const MainView(),
              ),
            ),
          ),
          const Spacer(),
          Wrap(
            spacing: 2,
            children: [
              for (int i = 0; i < 12; i++)
                ElevatedButton(
                  child: Text('${i + 1}'),
                  onPressed: () {
                    ref.read(actViewStateProvider.notifier).onPress(i);
                  },
                ),
              ElevatedButton(
                onPressed: () {
                  final player = AudioPlayer();
                  const fileName = 'sounds/output.mp3';
                  player.setAsset('assets/$fileName').then(
                        (_) => player.play(),
                      );

                  if (noiseAnimationController!.value == 1) {
                    noiseAnimationController!.reverse();
                  } else {
                    noiseAnimationController!.forward();
                  }
                },
                child: const Text('Break Screen(B)'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(actViewStateProvider.notifier).reset();
                },
                child: const Text('Reset(Enter)'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(actViewStateProvider.notifier).showAll();
                },
                child: const Text('Show All(Space)'),
              ),
              ElevatedButton(
                onPressed: () {
                  final shadowLevel = ref.read(shadowOverlayStateProvider);
                  if (shadowLevel == 1.0) {
                    ref.read(shadowOverlayStateProvider.notifier).state = 0.0;
                  } else {
                    ref.read(shadowOverlayStateProvider.notifier).state = 1.0;
                  }
                },
                child: const Text('Switch Shadow Level(L)'),
              )
            ],
          )
        ],
      ),
    );
  }
}
