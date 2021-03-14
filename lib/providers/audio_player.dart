import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum audioStateEnum { STOPPED, PLAYING, PAUSED }

class AudioPlayerProvider extends ChangeNotifier {
  Duration totalDuration;
  Duration position;
  audioStateEnum audioState;
  String source;

  AudioPlayerProvider() {
    initAudio();
  }

  AudioPlayer audioPlayer = AudioPlayer();

  initAudio() {
    source =
        'https://www.sautuliman.com/wp-content/uploads/Zikr-al-Husain-Khair-Zad-al-Zakireen.mp3';
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == AudioPlayerState.STOPPED)
        audioState = audioStateEnum.STOPPED;
      if (playerState == AudioPlayerState.PLAYING)
        audioState = audioStateEnum.PLAYING;
      if (playerState == AudioPlayerState.PAUSED)
        audioState = audioStateEnum.PAUSED;
      notifyListeners();
    });
    playAudio();
  }

  playAudio() {
    audioPlayer.play(source);
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  stopAudio() {
    audioPlayer.stop();
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }
}
