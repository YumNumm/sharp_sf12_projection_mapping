import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ysfh_final/model/text_item.dart';

part 'controller.g.dart';

class TextStatsModel {
  TextStatsModel({
    required this.textItems,
    required this.shouldBlack,
    required this.noizeLevel,
    required this.animationDuration,
    required this.animationPersistance,
  });

  final List<TextItem> textItems;
  final List<AnimationController> animationControllers = [];
  final bool shouldBlack;
  final double noizeLevel;
  final Duration animationDuration;
  final Duration animationPersistance;

  TextStatsModel copyWith({
    List<TextItem>? textItems,
    bool? shouldBlack,
    double? noizeLevel,
    Duration? animationDuration,
    Duration? animationPersistance,
  }) {
    return TextStatsModel(
      textItems: textItems ?? this.textItems,
      shouldBlack: shouldBlack ?? this.shouldBlack,
      noizeLevel: noizeLevel ?? this.noizeLevel,
      animationDuration: animationDuration ?? this.animationDuration,
      animationPersistance: animationPersistance ?? this.animationPersistance,
    );
  }
}

@riverpod
class TextStates extends _$TextStates {
  List<bool> isProcessing = List.filled(12, false);

  List<AudioPlayer> audioPlayers = List.generate(
    12,
    (index) => AudioPlayer(),
  );

  List<Timer> timers = List.generate(
    12,
    (index) => Timer(Duration.zero, () {}),
  );

  @override
  TextStatsModel build() {
    /* #ff0000
#ff803b
#ffd492
#ffd070
#fff556
#cafb28
#8efd75

#fe7bdc
#a27dfc
#4053fd
#42affe
#9cebdd
*/
    return TextStatsModel(
      noizeLevel: 0,
      textItems: [
        const TextItem(
          text: 'M',
          color: Color.fromARGB(255, 255, 0, 0),
          isHead: true,
        ),
        const TextItem(
          text: 'i',
          color: Color.fromARGB(255, 255, 128, 59),
        ),
        const TextItem(
          text: 'r',
          color: Color.fromARGB(255, 255, 212, 146),
        ),
        const TextItem(
          text: 'a',
          color: Color.fromARGB(255, 255, 208, 112),
        ),
        const TextItem(
          text: 'c',
          color: Color.fromARGB(255, 255, 245, 86),
        ),
        const TextItem(
          text: 'l',
          color: Color.fromARGB(255, 202, 251, 40),
        ),
        const TextItem(
          text: 'e',
          color: Color.fromARGB(255, 142, 253, 117),
        ),
        const TextItem(
          text: 'G',
          color: Color.fromARGB(255, 254, 123, 220),
          isHead: true,
        ),
        const TextItem(
          text: 'r',
          color: Color.fromARGB(255, 162, 125, 252),
        ),
        const TextItem(
          text: 'a',
          color: Color.fromARGB(255, 64, 83, 253),
        ),
        const TextItem(
          text: 'd',
          color: Color.fromARGB(255, 66, 175, 254),
        ),
        const TextItem(
          text: 'e',
          color: Color.fromARGB(255, 156, 235, 221),
        ),
      ],
      shouldBlack: false,
      animationDuration: const Duration(milliseconds: 250),
      animationPersistance: const Duration(milliseconds: 600),
    );
  }

  void onPress(int target, {bool shouldSound = true}) {
    if (shouldSound) {
      // 音を鳴らす
      final player = AudioPlayer();
      final fileName = 'sounds/${(target + 1).toString().padLeft(2, "0")}.mp3';
      player.setAsset('assets/$fileName').then(
            (_) => player.play(),
          );
    }

    // 実行中の場合は無視
    if (isProcessing[target]) {
      return;
    }

    // 当該のTextItemのshouldShowがfalseの場合はtrueにする
    if (!state.textItems[target].shouldShow) {
      state = state.copyWith(
        textItems: [
          ...state.textItems.sublist(0, target),
          state.textItems[target].copyWith(shouldShow: true),
          ...state.textItems.sublist(target + 1),
        ],
      );
      return;
    }
    // 実行中にする
    isProcessing[target] = true;
    // 当該のTextItemのshouldShowがtrueの場合はisShiningをtrueにする
    state = state.copyWith(
      textItems: [
        ...state.textItems.sublist(0, target),
        state.textItems[target].copyWith(isShining: true),
        ...state.textItems.sublist(target + 1),
      ],
    );
    // 150ms後に実行中を解除
    timers[target].cancel();
    timers[target] = Timer(state.animationPersistance, () {
      isProcessing[target] = false;
      // isShiningがtrueの場合はfalseにする
      if (state.textItems[target].isShining) {
        state = state.copyWith(
          textItems: [
            ...state.textItems.sublist(0, target),
            state.textItems[target].copyWith(isShining: false),
            ...state.textItems.sublist(target + 1),
          ],
        );
      }
    });
  }

  void randomPress(int targetCount) {
    final targets = (List<int>.generate(12, (index) => index)..shuffle())
        .sublist(0, targetCount);
    for (final target in targets) {
      onPress(target, shouldSound: false);
    }
  }

  void showAll() {
    state = state.copyWith(
      textItems: state.textItems
          .map(
            (e) => e.copyWith(
              shouldShow: true,
              isShining: true,
            ),
          )
          .toList(),
    );
  }

  void reset() {
    state = build();
    isProcessing = List.filled(12, false);
  }

  void breakScreen() {
    // 音を鳴らす
  }

  void setAnimationDuration(Duration duration) {
    state = state.copyWith(animationDuration: duration);
  }

  void setAnimationPersistance(Duration duration) {
    state = state.copyWith(animationPersistance: duration);
  }
}
