import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharp_sf12_projection_mapping/view/act_view/act_view.dart';
import 'package:url_launcher/url_launcher.dart';

final mainViewModelProvider = Provider<MainViewModel>(
  (ref) => MainViewModel(),
);

class MainViewModel {
  MainViewModel();

  Future<void> onFloatingActionButtonPressed(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const ActView(),
        ),
      );

  void onLicenseButtonPressed(BuildContext context) => showAboutDialog(
        context: context,
        applicationName: '#SF12 Projection Mapping App',
        applicationVersion: '1.1.0 Public Archive',
        applicationLegalese:
            'Produced by YSFH 12th Projection Mapping Project 2023\n'
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
      );
}
