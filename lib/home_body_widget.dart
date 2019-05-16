import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:time_scribe/main.dart';

class HomeBodyWidget extends StatefulWidget {
  static HomeBodyWidgetState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<HomeBodyWidgetState>());
  HomeBodyWidgetState createState() => new HomeBodyWidgetState();
}

class HomeBodyWidgetState extends State<HomeBodyWidget> {
  String _currActName = null;
  Icon _currActIcon = null;
  TimerService timerService = null;
  bool _activeActivity = false;
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    timerService = TimerService.of(context);
    return Column(
      children: <Widget>[
        // Top row containing stopwatch
        Container(
          color: Colors.white,
          child: _activeActivity
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _currActIcon == null
                            ? Icon(Icons.play_arrow)
                            : _currActIcon,
                        _currActName == null
                            ? Text("Tap an Activity!")
                            : Text(_currActName),
                      ],
                    ),
                    AnimatedBuilder(
                        animation: timerService,
                        builder: (context, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                               Text('${timerService.currentDuration.inSeconds}'),
                              FlatButton(
                                color: Colors.white,
                                onPressed: !timerService.isRunning
                                    ? timerService.start
                                    : timerService.stop,
                                child: Icon(!timerService.isRunning
                                    ? Icons.play_arrow
                                    : Icons.stop),
                              ),
                            ],
                          );
                        }),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _currActIcon == null
                            ? Icon(Icons.play_arrow)
                            : _currActIcon,
                        _currActName == null
                            ? Text("Tap an Activity!")
                            : Text(_currActName),
                      ],
                    ),
                  ],
                ),
        ),

        // Grid of activities
        Wrap(
          children: gridView(),
        ),
        FloatingActionButton(
          onPressed: () {
            addActivityAlert();
          },
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  List<Widget> gridView() {
    // Loop through saved data and construct RaisedButtons
    List<Widget> retList = new List<Widget>();
    for (var i = 0; i < 10; i++) {
      retList.add(newButton(new Icon(Icons.accessible_forward), "Test $i"));
    }
    return retList;
  }

  Widget newButton(Icon icon, String name) {
    return new RaisedButton(
      child: Column(
        children: <Widget>[
          icon,
          Text(name),
        ],
      ),
      elevation: 4.0,
      splashColor: Colors.lightBlue,
      onPressed: () {
        _changeActivity(icon, name);
      },
    );
  }

  /// Change the top row to represent the activity selected
  void _changeActivity(Icon icon, String name) {
    setState(() {
      _currActIcon = icon;
      _currActName = name;
      _activeActivity = true;
    });
    // End timer
    // Save timer time to whatever data holder
  }

  void addActivityAlert(){
    Alert(
      context: context,
      type: AlertType.info,
      title: "Add a new Activity",
      image: Image.asset("assets/plus.png"),
    ).show();
  }

}

// String array of names so no name duplicates
