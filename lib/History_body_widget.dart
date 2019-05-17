import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HistoryBodyWidget extends StatefulWidget {
  HistoryBodyWidgetState createState() => new HistoryBodyWidgetState();
}

class HistoryBodyWidgetState extends State<HistoryBodyWidget> {
  final GlobalKey<HistoryBodyWidgetState> _chartKey =
      new GlobalKey<HistoryBodyWidgetState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeAnimatedTextKit(
                duration: Duration(milliseconds: 10000),
                isRepeatingAnimation: false,
                text: ["Your History"],
                textStyle:
                    TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              AnimatedCircularChart(
                size: Size(300.0, 300.0),
                initialChartData: _testData,
                chartType: CircularChartType.Pie,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 120.0,
                    height: 60.0,
                    child: RaisedButton(
                      child: const Text("Today"),
                      color: Colors.white70,
                      elevation: 4.0,
                      splashColor: Colors.lightBlue,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ButtonTheme(
                    minWidth: 120.0,
                    height: 60.0,
                    child: RaisedButton(
                      child: const Text("All Time"),
                      color: Colors.white70,
                      elevation: 4.0,
                      splashColor: Colors.lightBlue,
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

final List<CircularStackEntry> _testData = [
  new CircularStackEntry(<CircularSegmentEntry>[
    new CircularSegmentEntry(500.0, Colors.redAccent, rankKey: "Studying"),
    new CircularSegmentEntry(1000.0, Colors.blueAccent, rankKey: "Programming"),
    new CircularSegmentEntry(2000.0, Colors.greenAccent, rankKey: "Sleeping"),
    new CircularSegmentEntry(1000.0, Colors.purpleAccent, rankKey: "Writing"),
  ])
];
