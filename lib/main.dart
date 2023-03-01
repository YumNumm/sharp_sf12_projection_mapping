import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/model/text_item.dart';
import 'package:sharp_sf12_projection_mapping/provider/flag_provider.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.viewmodel.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/component/control_panel.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/component/noise_widget.dart';
import 'package:sharp_sf12_projection_mapping/view/main_view/main_view.dart';
import 'package:sharp_sf12_projection_mapping/widget/shadow_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainView(),
      navigatorKey: navigatorKey,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      builder: (context, child) {
        final flags = ref.watch(flagProvider);
        final actState = ref.watch(actViewStateProvider);
        final body = Stack(
          children: [
            if (child != null) child,
            const IgnorePointer(
              child: ShadowOverlay(),
            ),
            if (flags.showDebugInfo) DebugInfoWidget(actState: actState),
            if (flags.showControlBoard) const ControlPanel(),
            const IgnorePointer(
              child: NoiseWidget(),
            ),
          ],
        );
        if (flags.showBanner) {
          return Banner(
            message: '#SF12',
            location: BannerLocation.topEnd,
            color: Colors.blueAccent,
            child: body,
          );
        }
        return body;
      },
    );
  }
}

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
