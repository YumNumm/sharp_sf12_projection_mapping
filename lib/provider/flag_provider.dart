import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class FlagState {
  const FlagState({
    this.showBanner = true,
    this.showControlBoard = kIsWeb,
    this.showDebugInfo = false,
  });

  final bool showBanner;
  final bool showControlBoard;
  final bool showDebugInfo;

  FlagState copyWith({
    bool? showBanner,
    bool? showControlBoard,
    bool? showDebugInfo,
  }) {
    return FlagState(
      showBanner: showBanner ?? this.showBanner,
      showControlBoard: showControlBoard ?? this.showControlBoard,
      showDebugInfo: showDebugInfo ?? this.showDebugInfo,
    );
  }
}

class FlagStateNotifier extends StateNotifier<FlagState> {
  FlagStateNotifier()
      : super(
          const FlagState(),
        );

  void update({
    bool? showBanner,
    bool? showControlBoard,
    bool? showDebugInfo,
  }) {
    state = state.copyWith(
      showBanner: showBanner,
      showControlBoard: showControlBoard,
      showDebugInfo: showDebugInfo,
    );
  }
}

final flagStateProvider = StateNotifierProvider<FlagStateNotifier, FlagState>(
  (ref) => FlagStateNotifier(),
);
