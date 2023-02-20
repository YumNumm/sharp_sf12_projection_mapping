import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:ysfh_final/intent/intents.dart';
import 'package:ysfh_final/provider/controller.dart';
import 'package:ysfh_final/widget/noise.dart';

Map<Type, CallbackAction> getActions(WidgetRef ref) {
  return {
    OnKeyPressIntent: CallbackAction<OnKeyPressIntent>(
      onInvoke: (OnKeyPressIntent intent) {
        ref.read(textStatesProvider.notifier).onPress(intent.target - 1);
        return null;
      },
    ),
    ResetIntent: CallbackAction<ResetIntent>(
      onInvoke: (ResetIntent intent) {
        ref.read(textStatesProvider.notifier).reset();
        noiseAnimationController!.animateTo(1);
        return null;
      },
    ),
    ShowAllIntent: CallbackAction<ShowAllIntent>(
      onInvoke: (ShowAllIntent intent) {
        ref.read(textStatesProvider.notifier).showAll();
        return null;
      },
    ),
    ShowTitleBarIntent: CallbackAction<ShowTitleBarIntent>(
      onInvoke: (ShowTitleBarIntent intent) {
        windowManager.setTitleBarStyle(TitleBarStyle.normal);
        return null;
      },
    ),
    HideTitleBarIntent: CallbackAction<HideTitleBarIntent>(
      onInvoke: (HideTitleBarIntent intent) {
        windowManager.setTitleBarStyle(TitleBarStyle.hidden);
        return null;
      },
    ),
    TransitToBlackScreen: CallbackAction<TransitToBlackScreen>(
      onInvoke: (_) {
        ref.read(textStatesProvider.notifier).switchBlack();
        return null;
      },
    ),
  };
}
