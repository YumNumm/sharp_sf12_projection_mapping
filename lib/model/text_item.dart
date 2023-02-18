import 'package:flutter/material.dart';

@immutable
class TextItem {
  const TextItem({
    required this.text,
    required this.gradient,
    this.isHead = false,
    this.isShining = false,
    this.shouldShow = false,
  });
  final String text;
  final Gradient gradient;
  final bool isHead;
  final bool isShining;
  final bool shouldShow;

  TextItem copyWith({
    String? text,
    Gradient? gradient,
    bool? isHead,
    bool? isShining,
    bool? shouldShow,
  }) {
    return TextItem(
      text: text ?? this.text,
      gradient: gradient ?? this.gradient,
      isHead: isHead ?? this.isHead,
      isShining: isShining ?? this.isShining,
      shouldShow: shouldShow ?? this.shouldShow,
    );
  }
}
