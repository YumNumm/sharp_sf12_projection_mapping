import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/intent/actions.dart';
import 'package:sharp_sf12_projection_mapping/intent/shortcuts.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.viewmodel.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/component/base_picture.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/component/noise_widget.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/component/text_item_widget.dart';

class ActView extends HookConsumerWidget {
  const ActView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        Future(() async {
          // 画面サイズを取得
          final size = MediaQuery.of(context).size;
          // 画面サイズを登録
          ref.read(actViewStateProvider.notifier)
            ..setDisplaySize(size)
            ..reset();
        });
        return null;
      },
      [],
    );

    final state = ref.watch(actViewStateProvider);
    return FocusableActionDetector(
      shortcuts: shortcuts,
      actions: getActions(ref),
      autofocus: true,
      focusNode: useFocusNode(),
      child: GestureDetector(
        onTapDown: ref.read(actViewStateProvider.notifier).onTapDown,
        onHorizontalDragEnd: (_) =>
            ref.read(actViewStateProvider.notifier).showAll(),
        onVerticalDragEnd: (_) =>
            ref.read(actViewStateProvider.notifier).reset(),
        onDoubleTap: ref.read(actViewStateProvider.notifier).startBreakScreen,
        onLongPress: ref.read(actViewStateProvider.notifier).backToMainView,
        child: Stack(
          children: [
            Container(
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
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[1],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[2],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[3],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[4],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[5],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[6],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            TextItemWidget(
                              textItem: state[7],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[8],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[9],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[10],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                            TextItemWidget(
                              textItem: state[11],
                              animationDuration: ref
                                  .read(actViewStateProvider.notifier)
                                  .animationDuration,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const NoiseWidget()
          ],
        ),
      ),
    );
  }
}
