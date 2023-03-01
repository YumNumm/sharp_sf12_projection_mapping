import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/intent/intents.dart';
import 'package:sharp_sf12_projection_mapping/main.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.viewmodel.dart';
import 'package:sharp_sf12_projection_mapping/view/main_view/main_view.dart';

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
    BreakScreenIntent: CallbackAction<BreakScreenIntent>(
      onInvoke: (_) {
        ref.read(actViewStateProvider.notifier).startBreakScreen();
        return null;
      },
    ),
    SwitchShadowLevelIntent: CallbackAction<SwitchShadowLevelIntent>(
      onInvoke: (_) {
        ref.read(actViewStateProvider.notifier).switchShadowLevel();
        return null;
      },
    ),
    ToMainViewIntent: CallbackAction<ToMainViewIntent>(
      onInvoke: (_) {
        Navigator.of(navigatorKey.currentContext!).pushReplacement(
          MaterialPageRoute<void>(
            builder: (context) => const MainView(),
          ),
        );
        return null;
      },
    ),
  };
}

bool isBlank = true;
