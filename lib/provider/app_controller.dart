import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_controller.g.dart';

@immutable
class AppStateModel {
  const AppStateModel({
    required this.blackLevel,
  });

  /// 画面全体 黒のオーバーレイの透明度
  final double blackLevel;

  AppStateModel copyWith({
    double? blackLevel,
  }) {
    return AppStateModel(
      blackLevel: blackLevel ?? this.blackLevel,
    );
  }
}

@riverpod
class AppState extends _$AppState {
  @override
  AppStateModel build() {
    return const AppStateModel(
      blackLevel: 0,
    );
  }
}
