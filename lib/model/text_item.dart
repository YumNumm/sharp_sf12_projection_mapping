import 'package:flutter/material.dart';

@immutable
class TextItem {
  const TextItem({
    required this.text,
    required this.color,
    this.isHead = false,
    this.isShining = false,
    this.shouldShow = false,
  });
  final String text;
  final bool isHead;
  final bool isShining;
  final bool shouldShow;
  final Color color;

  TextItem copyWith({
    String? text,
    Color? color,
    bool? isHead,
    bool? isShining,
    bool? shouldShow,
  }) {
    return TextItem(
      text: text ?? this.text,
      color: color ?? this.color,
      isHead: isHead ?? this.isHead,
      isShining: isShining ?? this.isShining,
      shouldShow: shouldShow ?? this.shouldShow,
    );
  }
}
