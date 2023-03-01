import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/provider/flag_provider.dart';
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
              if (kIsWeb || !Platform.isMacOS)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: t.colorScheme.primaryContainer,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'このデバイスでの動作は検証していません。\n'
                        'パフォーマンスやサウンドで不具合が発生する可能性があります。',
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
                      'このソフトウェアは、#SF12 Projection Mapping App として開発されています。',
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
              const Divider(),
              Container(
                decoration: BoxDecoration(
                  color: t.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: t.colorScheme.secondary,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      'FLAG CONTROLLER',
                      style: t.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: t.colorScheme.secondary,
                      ),
                    ),
                    // Flag showBanner
                    ListTile(
                      title: const Text('SHOW_BANNER'),
                      trailing: Switch.adaptive(
                        value: ref.watch(flagProvider).showBanner,
                        onChanged: (value) =>
                            ref.read(flagProvider.notifier).update(
                                  showBanner: value,
                                ),
                      ),
                    ),
                    // Flag showControlBoard
                    ListTile(
                      title: const Text('SHOW_CONTROL_BOARD'),
                      trailing: Switch.adaptive(
                        value: ref.watch(flagProvider).showControlBoard,
                        onChanged: (value) =>
                            ref.read(flagProvider.notifier).update(
                                  showControlBoard: value,
                                ),
                      ),
                    ),
                    // Flag showDebugInfo
                    ListTile(
                      title: const Text('SHOW_DEBUG_INFO'),
                      trailing: Switch.adaptive(
                        value: ref.watch(flagProvider).showDebugInfo,
                        onChanged: (value) =>
                            ref.read(flagProvider.notifier).update(
                                  showDebugInfo: value,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
