import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:musicApp/helpers/string_utils.dart';
import 'package:musicApp/providers/audio_player.dart';
import 'package:musicApp/widgets/preset_marquee.dart';
import 'package:provider/provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final audio = Provider.of<AudioPlayerProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("audio player"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.network(
                      'https://www.sautuliman.com/wp-content/uploads/2018/03/saut-53-cover.jpg',
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "SONG TITLE + ${audio.audioState}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PresetMarquee(
                      text: 'Source: ${audio.source}',
                    )
                  ],
                ),
              ),
              Consumer<AudioPlayerProvider>(
                builder: (_, audio, child) => Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatDuration(audio.position)),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                            trackHeight: 15,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5)),
                        child: Slider(
                          value: audio.position == null
                              ? 0
                              : audio.position.inSeconds.toDouble(),
                          min: 0,
                          max: audio.totalDuration == null
                              ? 20
                              : audio.totalDuration.inSeconds.toDouble(),
                          activeColor: Color(0xff6f3d2e),
                          inactiveColor: Color(0xff6f3d2e).withOpacity(0.3),
                          onChanged: (value) {
                            audio.seekAudio(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                    ),
                    Text(formatDuration(audio.totalDuration)),
                  ],
                )),
              ),
              Consumer<AudioPlayerProvider>(
                builder: (context, audio, child) => Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous),
                        onPressed: null,
                        iconSize: 36,
                      ),
                      IconButton(
                        icon: audio.audioState == audioStateEnum.PLAYING
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        onPressed: () {
                          audio.audioState == audioStateEnum.PLAYING
                              ? audio.pauseAudio()
                              : audio.playAudio();
                        },
                        iconSize: 36,
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next),
                        onPressed: null,
                        iconSize: 36,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
