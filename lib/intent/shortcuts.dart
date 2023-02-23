import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ysfh_final/intent/intents.dart';

const shortcuts = <ShortcutActivator, Intent>{
  SingleActivator(LogicalKeyboardKey.digit1): OnKeyPressIntent(1),
  SingleActivator(LogicalKeyboardKey.digit2): OnKeyPressIntent(2),
  SingleActivator(LogicalKeyboardKey.digit3): OnKeyPressIntent(3),
  SingleActivator(LogicalKeyboardKey.digit4): OnKeyPressIntent(4),
  SingleActivator(LogicalKeyboardKey.digit5): OnKeyPressIntent(5),
  SingleActivator(LogicalKeyboardKey.digit6): OnKeyPressIntent(6),
  SingleActivator(LogicalKeyboardKey.digit7): OnKeyPressIntent(7),
  SingleActivator(LogicalKeyboardKey.digit8): OnKeyPressIntent(8),
  SingleActivator(LogicalKeyboardKey.digit9): OnKeyPressIntent(9),
  SingleActivator(LogicalKeyboardKey.digit0): OnKeyPressIntent(10),
  SingleActivator(LogicalKeyboardKey.minus): OnKeyPressIntent(11),
  SingleActivator(LogicalKeyboardKey.keyQ): OnKeyPressIntent(11),
  SingleActivator(LogicalKeyboardKey.keyW): OnKeyPressIntent(12),
  SingleActivator(LogicalKeyboardKey.caret): OnKeyPressIntent(12),
  SingleActivator(LogicalKeyboardKey.enter): ResetIntent(),
  SingleActivator(LogicalKeyboardKey.space): ShowAllIntent(),
  SingleActivator(LogicalKeyboardKey.keyT): ShowTitleBarIntent(),
  SingleActivator(LogicalKeyboardKey.keyR): HideTitleBarIntent(),
  SingleActivator(LogicalKeyboardKey.keyB): BrakeScreenIntent(),
};
