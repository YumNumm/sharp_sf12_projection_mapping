// ignore_for_file: avoid_setters_without_getters, use_setters_to_change_properties

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharp_sf12_projection_mapping/main.dart';
import 'package:sharp_sf12_projection_mapping/model/text_item.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/component/noise_widget.dart';
import 'package:sharp_sf12_projection_mapping/view/main_view/main_view.dart';
import 'package:sharp_sf12_projection_mapping/widget/shadow_overlay_viewmodel.dart';

part 'act_view.viewmodel.g.dart';

class TextStatsModel {
  TextStatsModel({
    required this.textItems,
  });

  final List<TextItem> textItems;

  TextStatsModel copyWith({
    List<TextItem>? textItems,
    bool? shouldBlack,
    double? noizeLevel,
    bool? isBlank,
  }) {
    return TextStatsModel(
      textItems: textItems ?? this.textItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'textItems': textItems.map((x) => x.toJson()).toList(),
    };
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

  Size displaySize = Size.zero;

  @override
  List<TextItem> build() {
    animationDuration = const Duration(milliseconds: 250);
    animationPersistance = const Duration(milliseconds: 600);
    return [
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
    ];
  }

  void onPress(int target, {bool shouldSound = true}) {
    if (shouldSound) {
      // ???????????????
      final player = AudioPlayer();
      final fileName = 'sounds/${(target + 1).toString().padLeft(2, "0")}.mp3';
      player.setAsset('assets/$fileName').then(
            (_) => player.play(),
          );
    }

    // ?????????TextItem???showPaleColor???false????????????true?????????
    // ???????????????????????????????????????????????????????????????????????????
    if (!state[target].showPaleColor) {
      state = [
        ...state.sublist(0, target),
        state[target].copyWith(showPaleColor: true),
        ...state.sublist(target + 1),
      ];
      return;
    }

    // ??????????????????????????????????????????
    state = [
      ...state.sublist(0, target),
      state[target].copyWith(isShining: true),
      ...state.sublist(target + 1),
    ];
    // animationPersistance????????????????????????????????????????????????
    timers[target].cancel();
    timers[target] = Timer(animationPersistance, () {
      // isShining???true????????????false?????????
      if (state[target].isShining) {
        state = [
          ...state.sublist(0, target),
          state[target].copyWith(isShining: false),
          ...state.sublist(target + 1),
        ];
      }
    });
  }

  /// [targetCount]?????????????????????????????????????????????????????????
  void randomPress(int targetCount) =>
      (List<int>.generate(12, (index) => index)..shuffle())
          .sublist(0, targetCount)
          .forEach(
            (e) => onPress(
              e,
              shouldSound: !kIsWeb,
            ),
          );

  /// ???????????????????????????????????????????????????????????????????????????
  void showAll() {
    state = state
        .map(
          (e) => e.copyWith(
            showPaleColor: true,
            isShining: true,
          ),
        )
        .toList();
  }

  /// ??????????????????
  void reset() => state = build();

  void setAnimationDuration(Duration duration) => animationDuration = duration;

  void setAnimationPersistance(Duration duration) =>
      animationPersistance = duration;

  void onTapDown(TapDownDetails details) {
    // ??????????????????????????????
    final tapPosition = details.localPosition;
    // ??????????????????12??????????????????????????????????????????????????????????????????
    final tapIndex = (tapPosition.dx / displaySize.width * 12).floor();
    // ????????????????????????????????????????????????????????????
    onPress(tapIndex);
  }

  void switchShadowLevel() {
    final shadowLevel = ref.read(shadowOverlayStateProvider);
    if (shadowLevel == 1.0) {
      ref.read(shadowOverlayStateProvider.notifier).state = 0.0;
    } else {
      ref.read(shadowOverlayStateProvider.notifier).state = 1.0;
    }
  }

  void startBreakScreen() {
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
  }

  void setDisplaySize(Size size) => displaySize = size;

  void backToMainView() =>
      Navigator.of(navigatorKey.currentContext!).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const MainView(),
        ),
      );
}
