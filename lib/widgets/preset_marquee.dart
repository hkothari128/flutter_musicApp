import 'package:flutter/cupertino.dart';
import 'package:marquee/marquee.dart';

class PresetMarquee extends StatelessWidget {
  final String text;
  PresetMarquee({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 20,
        child: Marquee(
          text: text,
          style: TextStyle(fontWeight: FontWeight.w300),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
          velocity: 50.0,
          pauseAfterRound: Duration(seconds: 0),
          numberOfRounds: 3,
          accelerationDuration: Duration(seconds: 0),
          accelerationCurve: Curves.linear,
          decelerationDuration: Duration(milliseconds: 0),
          decelerationCurve: Curves.easeOut,
        ));
  }
}
