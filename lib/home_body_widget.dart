import 'package:flutter/material.dart';
import 'package:time_scribe/main.dart';

class ElapsedTime {
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.seconds,
    this.minutes,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle = const TextStyle(fontSize: 40.0, fontFamily: "Bebas Neue");
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class HomeBodyWidget extends StatefulWidget {
  HomeBodyWidgetState createState() => new HomeBodyWidgetState();
}

class HomeBodyWidgetState extends State<HomeBodyWidget> {

  static final Dependencies dependencies = new Dependencies();

  @override
  Widget build(BuildContext context) {
    var timerService = TimerService.of(context);
    return Column(
      children: <Widget>[
        timerSection,
      ],
    );
  }

  Widget timerSection = Container(

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget> [
        Icon(
          Icons.account_balance,
          color: Colors.black87,
        ),
        Text('Wow'),
        Icon(
          dependencies.stopwatch.isRunning ? Icons.play_arrow: Icons.stop,
          color: dependencies.stopwatch.isRunning ? Colors.green : Colors.red,
        ),
      ],
    ),
  );

}