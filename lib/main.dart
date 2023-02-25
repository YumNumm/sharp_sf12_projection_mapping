import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:ysfh_final/intent/actions.dart';
import 'package:ysfh_final/intent/shortcuts.dart';
import 'package:ysfh_final/model/text_item.dart';
import 'package:ysfh_final/provider/controller.dart';
import 'package:ysfh_final/widget/noise.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await windowManager.ensureInitialized();
    const windowOptions = WindowOptions(
      titleBarStyle: TitleBarStyle.hidden,
      title: 'YSFH Final 2023',
      alwaysOnTop: kDebugMode,
      center: true,
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
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

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(textStatesProvider).textItems;
    return FocusableActionDetector(
      shortcuts: shortcuts,
      actions: getActions(ref),
      autofocus: true,
      focusNode: useFocusNode(),
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: ref.watch(textStatesProvider).shouldBlack
                ? SizedBox.expand(
                    key: const ValueKey('black'),
                    child: Container(
                      color: Colors.black,
                    ),
                  )
                : Container(
                    key: const ValueKey('white'),
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                        child: FittedBox(
                          child: Stack(
                            fit: StackFit.passthrough,
                            alignment: Alignment.center,
                            // background image
                            children: [
                              const BasePicture(),
                              Row(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          const NoiseWidget()
        ],
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
      fontSize: 420,
      color: Colors.white,
      fontFamily: 'Calibri',
      fontWeight: FontWeight.bold,
    );
    return Transform.translate(
      offset: Offset(0, textItem.shouldShow ? 0 : -10000),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: Container(
          key: ValueKey(textItem.text + textItem.isShining.toString()),
          child: Stack(
            children: [
              if (textItem.isShining)
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 60,
                    sigmaY: 60,
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
