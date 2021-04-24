import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum audioStateEnum { STOPPED, PLAYING, PAUSED }

class AudioPlayerProvider extends ChangeNotifier {
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration totalDuration;
  Duration position;
  audioStateEnum audioState;
  String source;
  bool isInitialized = false;
  bool isBuffering = true;

  initAudio() {
    position = Duration(seconds: 0);
    totalDuration = Duration(seconds: 0);
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      isBuffering = false;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      switch (playerState) {
        case AudioPlayerState.STOPPED:
          audioState = audioStateEnum.STOPPED;
          break;
        case AudioPlayerState.PLAYING:
          audioState = audioStateEnum.PLAYING;
          break;
        case AudioPlayerState.PAUSED:
          audioState = audioStateEnum.PAUSED;
          break;
        default:
      }
      notifyListeners();
    });
    isInitialized = true;
  }

  Future<void> setSource(src) async {
    if (!isInitialized) initAudio();
    source = src;
    await audioPlayer.setUrl(source);
  }

  Future<void> playAudio() async {
    if (!isInitialized) initAudio();
    setBuffering(true);
    await audioPlayer.play(source);
    setBuffering(false);
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  stopAudio() {
    audioPlayer.stop();
  }

  setBuffering(buffering) {
    isBuffering = buffering;
    notifyListeners();
  }

  Future<void> seekAudio(Duration durationToSeek) async {
    setBuffering(true);
    await audioPlayer.seek(durationToSeek);
    if (audioState == audioStateEnum.PLAYING) {
      print("PLAYING");
      await audioPlayer.play(source);
    }
    setBuffering(false);
  }
}
