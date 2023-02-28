import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainView(),
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      builder: (context, child) {
        final body = Stack(
          children: [
            if (child != null) child,
            const IgnorePointer(
              child: ShadowOverlay(),
            ),
          ],
        );
        return Banner(
          message: '#SF12',
          location: BannerLocation.topEnd,
          color: Colors.blueAccent,
          child: body,
        );
      },
    );
  }
}
