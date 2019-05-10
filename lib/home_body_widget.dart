import 'package:flutter/material.dart';
import 'package:time_scribe/main.dart';

class HomeBodyWidget extends StatefulWidget {
  HomeBodyWidgetState createState() => new HomeBodyWidgetState();
}

class HomeBodyWidgetState extends State<HomeBodyWidget> {

  @override
  Widget build(BuildContext context) {
    var timerService = TimerService.of(context);
    return Column(
      children: <Widget>[
        Container( // Top row containing stopwatch
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              Column(
                children: <Widget> [
                  Icon(
                   Icons.account_balance,
                   color: Colors.black87,
                  ),
                  Text('Wow'),
                ],
              ),
              AnimatedBuilder(
                animation: timerService,
                builder: (context, child) {
                  return Row (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Text('${timerService.currentDuration.inSeconds}'),
                      FlatButton(
                        color: Colors.white,
                        onPressed: !timerService.isRunning ? timerService.start : timerService.stop,
                        child: Icon(!timerService.isRunning ? Icons.play_arrow : Icons.stop),
                      ),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
      ],
    );
  }

}