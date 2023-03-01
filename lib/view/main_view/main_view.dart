import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/provider/flag_provider.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.dart';
import 'package:url_launcher/url_launcher.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context);
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Image.asset(
            'assets/ysfh.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.5),
            colorBlendMode: BlendMode.screen,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.8),
            elevation: 0,
            title: const Text('#SF12 Projection Mapping App'),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (context) => const ActView(),
              ),
            ),
            label: const Text('開始'),
            icon: const Icon(Icons.play_arrow),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (kIsWeb || !Platform.isMacOS) ...[
                    Card(
                      elevation: 8,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'このプラットフォームでの動作は検証していません。\n'
                            'パフォーマンスやサウンドで不具合が発生する可能性があります。',
                            style: t.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            'このソフトウェアは、#SF12 Projection Mapping Projectの一部です。',
                            style: t.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          Text(
                            '使い方',
                            style: t.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '開始後 画面の任意の部分をタップ・数字の1-9,0,-,~キーを押して、文字を光らせることができます\n'
                            'ロングタップ・Escキーで 終了\n'
                            '2本指ピンチイン・Enterキーでリセット\n'
                            '2本指ピンチアウト・Spaceキーで全文字点灯\n'
                            'ダブルタップ・Bキーで壊れるアニメーション開始\n'
                            'Lキーで画面点灯・消灯切り替え',
                          ),
                          const Divider(),
                          // AboutDialog Elevated Button
                          ElevatedButton(
                            onPressed: () => showAboutDialog(
                              context: context,
                              applicationName: '#SF12 Projection Mapping App',
                              applicationVersion: '1.0.0',
                              applicationLegalese:
                                  'Produced by 2023 YSFH 12th Projection Mapping Project\n'
                                  'This software is released under the MIT License, see LICENSE.',
                              applicationIcon: const SizedBox(
                                width: 64,
                                height: 64,
                                child: Image(
                                  image: AssetImage('assets/ysfh.png'),
                                ),
                              ),
                              children: [
                                TextButton(
                                  child: const Text(
                                    'https://github.com/YumNumm/sharp_sf12_projection_mapping',
                                  ),
                                  onPressed: () {
                                    launchUrl(
                                      Uri.parse(
                                        'https://github.com/YumNumm/sharp_sf12_projection_mapping',
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                            child: const Text('ライセンス情報'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Card(
                    elevation: 2,
                    child: Padding(
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
                          Text(
                            'For testing and debugging purposes only.',
                            style: t.textTheme.titleSmall!.copyWith(
                              color: t.colorScheme.secondary,
                            ),
                          ),
                          // Flag showBanner
                          SwitchListTile.adaptive(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            value: ref.watch(flagProvider).showBanner,
                            onChanged: (value) =>
                                ref.read(flagProvider.notifier).update(
                                      showBanner: value,
                                    ),
                            title: const Text('SHOW_BANNER'),
                          ),
                          // Flag showControlBoard
                          SwitchListTile.adaptive(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            value: ref.watch(flagProvider).showControlBoard,
                            onChanged: (value) =>
                                ref.read(flagProvider.notifier).update(
                                      showControlBoard: value,
                                    ),
                            title: const Text('SHOW_CONTROL_BOARD'),
                          ),
                          SwitchListTile.adaptive(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            title: const Text('SHOW_DEBUG_INFO'),
                            value: ref.watch(flagProvider).showDebugInfo,
                            onChanged: (value) =>
                                ref.read(flagProvider.notifier).update(
                                      showDebugInfo: value,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
