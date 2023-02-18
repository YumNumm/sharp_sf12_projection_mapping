import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ysfh_final/model/text_item.dart';

part 'controller.g.dart';

@riverpod
class TextStates extends _$TextStates {
  List<bool> isProcessing = List.filled(12, false);

  List<AudioPlayer> audioPlayers = List.generate(
    12,
    (index) => AudioPlayer(),
  );

  @override
  List<TextItem> build() {
    return [
      const TextItem(
        text: 'M',
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 252, 70, 107),
            Color.fromARGB(255, 63, 94, 251),
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
            Color.fromARGB(255, 0, 242, 96),
            Color.fromARGB(255, 5, 117, 230),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      const TextItem(
        text: 'r',
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 3, 0, 30),
            Color.fromARGB(255, 115, 3, 192),
            Color.fromARGB(255, 236, 56, 188),
            Color.fromARGB(255, 253, 239, 249),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      const TextItem(
        text: 'a',
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 102, 125, 182),
            Color.fromARGB(255, 0, 130, 200),
            Color.fromARGB(255, 0, 130, 200),
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
            Color.fromARGB(255, 255, 153, 102),
            Color.fromARGB(255, 255, 94, 98),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      const TextItem(
        text: 'l',
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
        text: 'e',
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 57, 106, 252),
            Color.fromARGB(255, 41, 72, 255),
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
            Color.fromARGB(255, 12, 235, 235),
            Color.fromARGB(255, 32, 227, 178),
            Color.fromARGB(255, 41, 255, 198),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      const TextItem(
        text: 'a',
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
        text: 'd',
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
        text: 'e',
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 70),
            Color.fromARGB(255, 28, 181, 224),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ];
  }

  void onPress(int target) {
    // 音を鳴らす
    final player = audioPlayers[target];
    final fileName = 'sounds/${(target + 1).toString().padLeft(2, "0")}.mp3';
    player.setAsset('assets/$fileName').then(
          (_) => player.play(),
        );

    // 実行中の場合は無視
    if (isProcessing[target]) {
      return;
    }

    // 当該のTextItemのshouldShowがfalseの場合はtrueにする
    if (!state[target].shouldShow) {
      state = [
        ...state.sublist(0, target),
        state[target].copyWith(shouldShow: true),
        ...state.sublist(target + 1),
      ];
      return;
    }
    // 実行中にする
    isProcessing[target] = true;
    // 当該のTextItemのshouldShowがtrueの場合はisShiningをtrueにする
    state = [
      ...state.sublist(0, target),
      state[target].copyWith(isShining: true),
      ...state.sublist(target + 1),
    ];
    // 150ms後に実行中を解除
    Future.delayed(const Duration(milliseconds: 800), () {
      isProcessing[target] = false;
      // isShiningがtrueの場合はfalseにする
      if (state[target].isShining) {
        state = [
          ...state.sublist(0, target),
          state[target].copyWith(isShining: false),
          ...state.sublist(target + 1),
        ];
      }
    });
  }

  void reset() {
    state = build();
    isProcessing = List.filled(12, false);
  }
}
