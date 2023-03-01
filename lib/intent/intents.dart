import 'package:flutter/material.dart';

class OnKeyPressIntent extends Intent {
  const OnKeyPressIntent(this.target);
  final int target;
}

class ResetIntent extends Intent {
  const ResetIntent();
}

class ShowAllIntent extends Intent {
  const ShowAllIntent();
}

class BreakScreenIntent extends Intent {
  const BreakScreenIntent();
}

class SwitchShadowLevelIntent extends Intent {
  const SwitchShadowLevelIntent();
}

class ToMainViewIntent extends Intent {
  const ToMainViewIntent();
}
