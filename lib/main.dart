import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ysfh_final/model/text_item.dart';
import 'package:ysfh_final/provider/controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class OnKeyPressIntent extends Intent {
  const OnKeyPressIntent(this.target);
  final int target;
}

class ResetIntent extends Intent {
  const ResetIntent();
}

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(textStatesProvider);

    return FocusableActionDetector(
      shortcuts: const <ShortcutActivator, Intent>{
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
        SingleActivator(LogicalKeyboardKey.keyQ): OnKeyPressIntent(11),
        SingleActivator(LogicalKeyboardKey.keyW): OnKeyPressIntent(12),
        SingleActivator(LogicalKeyboardKey.enter): ResetIntent(),
      },
      actions: <Type, Action>{
        OnKeyPressIntent: CallbackAction<OnKeyPressIntent>(
          onInvoke: (OnKeyPressIntent intent) {
            ref.read(textStatesProvider.notifier).onPress(intent.target - 1);
            return null;
          },
        ),
        ResetIntent: CallbackAction<ResetIntent>(
          onInvoke: (ResetIntent intent) {
            ref.read(textStatesProvider.notifier).reset();
            return null;
          },
        ),
      },
      autofocus: true,
      focusNode: useFocusNode(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: [
              const Center(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.modulate,
                  ),
                  child: Expanded(child: BasePicture()),
                ),
              ),
              SizedBox.expand(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextItemWidget(
                      textItem: state[0],
                    ),
                    TextItemWidget(
                      textItem: state[1],
                    ),
                    TextItemWidget(
                      textItem: state[2],
                    ),
                    TextItemWidget(
                      textItem: state[3],
                    ),
                    TextItemWidget(
                      textItem: state[4],
                    ),
                    TextItemWidget(
                      textItem: state[5],
                    ),
                    TextItemWidget(
                      textItem: state[6],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    TextItemWidget(
                      textItem: state[7],
                    ),
                    TextItemWidget(
                      textItem: state[8],
                    ),
                    TextItemWidget(
                      textItem: state[9],
                    ),
                    TextItemWidget(
                      textItem: state[10],
                    ),
                    TextItemWidget(
                      textItem: state[11],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextItemWidget extends StatelessWidget {
  const TextItemWidget({
    required this.textItem,
    super.key,
  });

  final TextItem textItem;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 150,
      color: Colors.white,
      fontFamily: 'Calibri',
      fontWeight: FontWeight.bold,
    );
    return Transform.translate(
      offset: Offset(0, textItem.shouldShow ? 0 : -1000),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: Container(
          key: ValueKey(textItem.hashCode),
          child: Stack(
            children: [
              if (textItem.isShining)
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: ShaderMask(
                    shaderCallback: textItem.gradient.createShader,
                    child: Text(
                      textItem.text,
                      style: style.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              // 本体
              Text(
                textItem.text,
                style: style.copyWith(
                  color: textItem.isHead
                      ? const Color.fromARGB(255, 255, 0, 0)
                      : Colors.black,
                ),
              ),
              // ふち
              Text(
                textItem.text,
                style: style.copyWith(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.fill
                    ..strokeWidth = 1
                    ..isAntiAlias = true
                    ..color = textItem.isShining
                        ? textItem.isHead
                            ? const Color.fromARGB(255, 255, 17, 0)
                            : Colors.black
                        : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BasePicture extends StatelessWidget {
  const BasePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/1212123_base.png');
  }
}
