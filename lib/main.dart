import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ysfh_final/model/text_item.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // child: Expanded(child: BasePicture()),
              ),
            ),
            SizedBox.expand(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextItemWidget(
                    textItem: TextItem(
                      text: 'M',
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 153, 0),
                          Color.fromARGB(255, 0, 6, 170)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      isHead: true,
                    ),
                  ),
                ],
              ),
            )
          ],
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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: Container(
        key: ValueKey(textItem.hashCode),
        child: Stack(
          children: [
            Text(
              textItem.text,
              style: style.copyWith(
                color: isHead
                    ? const Color.fromARGB(255, 255, 0, 0)
                    : Colors.white,
              ),
            ),
            // ふち
            Text(
              textItem.text,
              style: style.copyWith(
                fontWeight: FontWeight.normal,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..isAntiAlias = true
                  ..color = textItem.isShining
                      ? const Color.fromARGB(255, 255, 0, 0)
                      : isHead
                          ? const Color.fromARGB(255, 255, 0, 0)
                              .withOpacity(0.7)
                          : Colors.grey,
              ),
            ),
            if (textItem.isShining)
              ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 153, 0),
                        Color.fromARGB(255, 0, 6, 170)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    textItem.text,
                    style: style,
                  ),
                ),
              ),
          ],
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
