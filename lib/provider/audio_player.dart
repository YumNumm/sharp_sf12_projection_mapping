import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class AudioPlayerState extends _$AudioPlayerState {
  @override
  bool build() {
    return false;
  }

  final _player = AudioPlayer();

  Future<void> initAudioPlayer() async{
    _player.

  }

  Future<void> playSound(String assetKey) async{

  }
}