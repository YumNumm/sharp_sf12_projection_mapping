import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class TextItem {
  const TextItem({
    required this.text,
    required this.gradient,
    this.isHead = false,
    this.isShining = false,
  });
  final String text;
  final Gradient gradient;
  final bool isHead;
  final bool isShining;
}
