// ignore_for_file: avoid_setters_without_getters, use_setters_to_change_properties

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharp_sf12_projection_mapping/model/text_item.dart';

part 'act_view.viewmodel.g.dart';

class TextStatsModel {
  TextStatsModel({
    required this.textItems,
    required this.shouldBlack,
    required this.noizeLevel,
    required this.isBlank,
  });

  final List<TextItem> textItems;
  final bool shouldBlack;
  final double noizeLevel;
  final bool isBlank;

  TextStatsModel copyWith({
    List<TextItem>? textItems,
    bool? shouldBlack,
    double? noizeLevel,
    bool? isBlank,
  }) {
    return TextStatsModel(
      textItems: textItems ?? this.textItems,
      shouldBlack: shouldBlack ?? this.shouldBlack,
      noizeLevel: noizeLevel ?? this.noizeLevel,
      isBlank: isBlank ?? this.isBlank,
    );
  }
}

@riverpod
class ActViewState extends _$ActViewState {
  Duration animationDuration = const Duration(milliseconds: 250);
  Duration animationPersistance = const Duration(milliseconds: 600);

  List<Timer> timers = List.generate(
    12,
    (index) => Timer(Duration.zero, () {}),
  );

  @override
  TextStatsModel build() {
    animationDuration = const Duration(milliseconds: 250);
    animationPersistance = const Duration(milliseconds: 600);
    return TextStatsModel(
      noizeLevel: 0,
      shouldBlack: false,
      isBlank: true,
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
          color: Color.fromARGB(255, 179, 229, 12),
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
          color: Color.fromARGB(255, 34, 159, 248),
        ),
        const TextItem(
          text: 'e',
          color: Color.fromARGB(255, 42, 223, 190),
        ),
      ],
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

    // 当該のTextItemのshowPaleColorがfalseの場合はtrueにする
    // つまり、完全に非表示状態の場合は、薄く表示して終了
    if (!state.textItems[target].showPaleColor) {
      state = state.copyWith(
        textItems: [
          ...state.textItems.sublist(0, target),
          state.textItems[target].copyWith(showPaleColor: true),
          ...state.textItems.sublist(target + 1),
        ],
      );
      return;
    }

    // 輝かせるアニメーションを開始
    state = state.copyWith(
      textItems: [
        ...state.textItems.sublist(0, target),
        state.textItems[target].copyWith(isShining: true),
        ...state.textItems.sublist(target + 1),
      ],
    );
    // animationPersistance後に輝かせるアニメーションを終了
    timers[target].cancel();
    timers[target] = Timer(animationPersistance, () {
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

  /// [targetCount]個のランダムなボタンを押したことにする
  void randomPress(int targetCount) =>
      (List<int>.generate(12, (index) => index)..shuffle())
          .sublist(0, targetCount)
          .forEach(onPress);

  /// 全てのボタンを押したことにして、その状態を維持する
  void showAll() {
    state = state.copyWith(
      textItems: state.textItems
          .map(
            (e) => e.copyWith(
              showPaleColor: true,
              isShining: true,
            ),
          )
          .toList(),
    );
  }

  /// 初期値に戻す
  void reset() => state = build();

  void setAnimationDuration(Duration duration) => animationDuration = duration;

  void setAnimationPersistance(Duration duration) =>
      animationPersistance = duration;
}
