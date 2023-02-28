import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/widget/shadow_overlay_viewmodel.dart';

class ShadowOverlay extends ConsumerWidget {
  const ShadowOverlay({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shadowLevel = ref.watch(shadowOverlayStateProvider);

    return AnimatedOpacity(
      opacity: shadowLevel,
      duration: const Duration(milliseconds: 50),
      child: Container(
        color: Colors.black,
      ),
    );
  }
}
