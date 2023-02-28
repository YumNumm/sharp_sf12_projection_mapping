import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sharp_sf12_projection_mapping/intent/intents.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.viewmodel.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/component/noise_widget.dart';
import 'package:sharp_sf12_projection_mapping/widget/shadow_overlay_viewmodel.dart';

Map<Type, CallbackAction> getActions(WidgetRef ref) {
  return {
    OnKeyPressIntent: CallbackAction<OnKeyPressIntent>(
      onInvoke: (OnKeyPressIntent intent) {
        ref.read(actViewStateProvider.notifier).onPress(intent.target - 1);
        return null;
      },
    ),
    ResetIntent: CallbackAction<ResetIntent>(
      onInvoke: (ResetIntent intent) {
        ref.read(actViewStateProvider.notifier).reset();
        return null;
      },
    ),
    ShowAllIntent: CallbackAction<ShowAllIntent>(
      onInvoke: (ShowAllIntent intent) {
        ref.read(actViewStateProvider.notifier).showAll();
        return null;
      },
    ),
    BrakeScreenIntent: CallbackAction<BrakeScreenIntent>(
      onInvoke: (_) {
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
        return null;
      },
    ),
    SwitchShadowLevelIntent: CallbackAction<SwitchShadowLevelIntent>(
      onInvoke: (_) {
        final shadowLevel = ref.read(shadowOverlayStateProvider);
        if (shadowLevel == 1.0) {
          ref.read(shadowOverlayStateProvider.notifier).state = 0.0;
        } else {
          ref.read(shadowOverlayStateProvider.notifier).state = 1.0;
        }
        return null;
      },
    ),
  };
}

bool isBlank = true;
