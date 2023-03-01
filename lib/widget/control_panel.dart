import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/main.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.viewmodel.dart';
import 'package:sharp_sf12_projection_mapping/view/main_view/main_view.dart';

class ControlPanel extends ConsumerWidget {
  const ControlPanel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.of(navigatorKey.currentContext!).pushReplacement(
              MaterialPageRoute<void>(
                builder: (context) => const MainView(),
              ),
            ),
          ),
          const Spacer(),
          Wrap(
            runSpacing: 2,
            spacing: 2,
            children: [
              for (int i = 0; i < 12; i++)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text('${i + 1}'),
                  onPressed: () =>
                      ref.read(actViewStateProvider.notifier).onPress(i),
                ),
              ElevatedButton(
                onPressed:
                    ref.read(actViewStateProvider.notifier).startBreakScreen,
                child: const Text('Break Screen(B)'),
              ),
              ElevatedButton(
                onPressed: ref.read(actViewStateProvider.notifier).reset,
                child: const Text('Reset(Enter)'),
              ),
              ElevatedButton(
                onPressed: ref.read(actViewStateProvider.notifier).showAll,
                child: const Text('Show All(Space)'),
              ),
              ElevatedButton(
                onPressed:
                    ref.read(actViewStateProvider.notifier).switchShadowLevel,
                child: const Text('Switch Shadow Level(L)'),
              )
            ],
          )
        ],
      ),
    );
  }
}
