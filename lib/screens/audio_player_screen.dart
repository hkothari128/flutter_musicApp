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
  // var _isLoading = true;
  var _isInitialized = false;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (!_isInitialized) {
      await setAudioSource();
      setState(() {
        _isInitialized = true;
        // _isLoading = false;
      });
    }
    super.didChangeDependencies();
  }

  Future<void> setAudioSource() async {
    await Provider.of<AudioPlayerProvider>(context, listen: false).setSource(
        'https://www.sautuliman.com/wp-content/uploads/Zikr-al-Husain-Khair-Zad-al-Zakireen.mp3');
  }

  @override
  Widget build(BuildContext context) {
    // final audio = Provider.of<AudioPlayerProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("audio player"),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            width: double.infinity,
            child: Consumer<AudioPlayerProvider>(
              child: Column(
                children: [
                  FadeInImage(
                      image: NetworkImage(
                          'https://www.sautuliman.com/wp-content/uploads/2018/03/saut-53-cover.jpg'),
                      width: double.infinity,
                      fit: BoxFit.contain,
                      placeholder:
                          AssetImage('assets/images/default_image.png')),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "SONG TITLE ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PresetMarquee(
                    text: 'Source: ',
                  )
                ],
              ),
              builder: (context, audio, ch) => Column(
                children: [
                  Expanded(
                    child: ch,
                  ),
                  Row(
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
                            onChanged: (value) async {
                              await audio
                                  .seekAudio(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                      ),
                      Text(formatDuration(audio.totalDuration)),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.skip_previous),
                          onPressed: null,
                          iconSize: 36,
                        ),
                        !audio.isInitialized || audio.isBuffering
                            ? CircularProgressIndicator()
                            : IconButton(
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
                ],
              ),
            )));
  }
}
