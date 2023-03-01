import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Flag {
  const Flag({
    this.showBanner = true,
    this.showControlBoard = kIsWeb,
    this.showDebugInfo = false,
  });

  final bool showBanner;
  final bool showControlBoard;
  final bool showDebugInfo;

  Flag copyWith({
    bool? showBanner,
    bool? showControlBoard,
    bool? showDebugInfo,
  }) {
    return Flag(
      showBanner: showBanner ?? this.showBanner,
      showControlBoard: showControlBoard ?? this.showControlBoard,
      showDebugInfo: showDebugInfo ?? this.showDebugInfo,
    );
  }
}

class FlagStateNotifier extends StateNotifier<Flag> {
  FlagStateNotifier()
      : super(
          const Flag(),
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

final flagProvider = StateNotifierProvider<FlagStateNotifier, Flag>(
  (ref) => FlagStateNotifier(),
);
