import 'package:flutter/material.dart';

@immutable
class TextItem {
  const TextItem({
    required this.text,
    required this.color,
    this.isHead = false,
    this.isShining = false,
    this.showPaleColor = false,
  });
  final String text;
  final bool isHead;
  final bool isShining;
  final bool showPaleColor;
  final Color color;

  TextItem copyWith({
    String? text,
    Color? color,
    bool? isHead,
    bool? isShining,
    bool? showPaleColor,
  }) {
    return TextItem(
      text: text ?? this.text,
      color: color ?? this.color,
      isHead: isHead ?? this.isHead,
      isShining: isShining ?? this.isShining,
      showPaleColor: showPaleColor ?? this.showPaleColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'color': '0x${color.value.toRadixString(16)}'.toUpperCase(),
      'isHead': isHead,
      'isShining': isShining,
      'showPaleColor': showPaleColor,
    };
  }
}
