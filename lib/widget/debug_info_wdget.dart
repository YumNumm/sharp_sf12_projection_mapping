import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sharp_sf12_projection_mapping/model/text_item.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/component/noise_widget.dart';

class DebugInfoWidget extends HookWidget {
  const DebugInfoWidget({
    super.key,
    required this.actState,
  });

  final List<TextItem> actState;

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        noiseAnimationController?.addListener(() {});

        return null;
      },
      [noiseAnimationController],
    );
    return SafeArea(
      child: IgnorePointer(
        child: SingleChildScrollView(
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noiseAnimationController?.toStringDetails() ??
                      'NOISE ANIMATION CONTROLLER\nNOT INITIALIZED YET',
                ),
                const Divider(),
                Text(
                  const JsonEncoder.withIndent('   ').convert(actState),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
