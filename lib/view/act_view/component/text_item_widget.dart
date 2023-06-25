import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sharp_sf12_projection_mapping/model/text_item.dart';

class TextItemWidget extends StatelessWidget {
  const TextItemWidget({
    required this.textItem,
    required this.animationDuration,
    super.key,
  });

  final TextItem textItem;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 420,
      color: Colors.white,
      fontFamily: 'Calibri',
      fontWeight: FontWeight.bold,
    );
    return Opacity(
      opacity: textItem.showPaleColor ? 1 : 0,
      child: AnimatedSwitcher(
        duration: animationDuration,
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
                  child: Text(
                    textItem.text,
                    style: style.copyWith(
                      color: textItem.color,
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
