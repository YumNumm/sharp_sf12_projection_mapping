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
  });

  final List<TextItem> textItems;
  final List<AnimationController> animationControllers = [];
  final bool shouldBlack;
  final double noizeLevel;

  TextStatsModel copyWith({
    List<TextItem>? textItems,
    bool? shouldBlack,
    double? noizeLevel,
  }) {
    return TextStatsModel(
      textItems: textItems ?? this.textItems,
      shouldBlack: shouldBlack ?? this.shouldBlack,
      noizeLevel: noizeLevel ?? this.noizeLevel,
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
    return TextStatsModel(
      noizeLevel: 0,
      textItems: [
        const TextItem(
          text: 'M',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 252, 70, 107),
              Color.fromARGB(255, 127, 0, 255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          isHead: true,
        ),
        const TextItem(
          text: 'i',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 127, 0, 255),
              Color.fromARGB(255, 225, 0, 255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'r',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 225, 0, 255),
              Color.fromARGB(255, 236, 56, 188),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'a',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 236, 56, 188),
              Color.fromARGB(255, 102, 125, 182),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'c',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 55, 194),
              Color.fromARGB(255, 228, 5, 9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'l',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 224, 0, 4),
              Color.fromARGB(255, 0, 104, 209),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'e',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 5, 117, 230),
              Color.fromARGB(255, 149, 17, 182),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'G',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 149, 17, 182),
              Color.fromARGB(255, 198, 66, 110),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          isHead: true,
        ),
        const TextItem(
          text: 'r',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 198, 66, 110),
              Color.fromARGB(255, 192, 57, 43),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'a',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 192, 57, 43),
              Color.fromARGB(255, 142, 68, 173),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'd',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 54, 209, 220),
              Color.fromARGB(255, 91, 134, 229),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const TextItem(
          text: 'e',
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 236, 56, 188),
              Color.fromARGB(255, 102, 125, 182),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ],
      shouldBlack: false,
    );
  }

  void onPress(int target) {
    // 音を鳴らす
    final player = AudioPlayer();
    final fileName = 'sounds/${(target + 1).toString().padLeft(2, "0")}.mp3';
    player.setAsset('assets/$fileName').then(
          (_) => player.play(),
        );

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
    timers[target] = Timer(const Duration(milliseconds: 800), () {
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

  void switchBlack() {
    state = state.copyWith(shouldBlack: !state.shouldBlack);
  }
}
