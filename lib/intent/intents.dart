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

class BrakeScreenIntent extends Intent {
  const BrakeScreenIntent();
}

class SwitchShadowLevelIntent extends Intent {
  const SwitchShadowLevelIntent();
}
