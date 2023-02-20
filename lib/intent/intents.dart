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

class ShowTitleBarIntent extends Intent {
  const ShowTitleBarIntent();
}

class HideTitleBarIntent extends Intent {
  const HideTitleBarIntent();
}

class TransitToBlackScreen extends Intent {
  const TransitToBlackScreen();
}
