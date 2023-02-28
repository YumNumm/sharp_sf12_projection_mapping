import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('#SF12 Projection Mapping App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (kIsWeb || Platform.isMacOS)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: t.colorScheme.primaryContainer,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'macOS以外での動作は検証していません。',
                        style: t.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: t.colorScheme.primaryContainer,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'このソフトウェアは、#SF12のプロジェクションマッピングのためのアプリです',
                      style: t.textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (context) => const ActView(),
                  ),
                ),
                elevation: 0,
                label: const Text('開始'),
                icon: const Icon(Icons.play_arrow),
              ),
            ]
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
