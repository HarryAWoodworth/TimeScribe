import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:time_scribe/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBodyWidget extends StatefulWidget {
  static HomeBodyWidgetState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<HomeBodyWidgetState>());
  HomeBodyWidgetState createState() => new HomeBodyWidgetState();
}

class HomeBodyWidgetState extends State<HomeBodyWidget> {
  String _currActName = null;
  Icon _currActIcon = null;
  TimerService timerService = null;
  bool _activeActivity = false;
  BuildContext _context;

  // For adding activities
  List<ButtonPair> _activityList = new List();
  List<String> _namesList = new List();
  String _newName = null;
  Icon _newIcon = null;

  // For Picker
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _context = context;
    timerService = TimerService.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
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
                              children: <Widget>[
                                Text('${timerService.currentDuration.inSeconds}'),
                                FlatButton(
                                color: Colors.lightBlue,
                                onPressed: !timerService.isRunning
                                    ? timerService.start
                                    : timerService.stop,
                                child: Icon(!timerService.isRunning
                                    ? Icons.play_arrow
                                    : Icons.stop),
                                ),
                            ]
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
      ),
    );
  }

  List<Widget> gridView() {
    // Loop through saved data and construct RaisedButtons
    List<Widget> retList = new List<Widget>();
    for (ButtonPair p in _activityList) {
      retList.add(newButton(new Icon(p.iconData), p.name));
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
  _changeActivity(Icon icon, String name) {
    setState(() {
      _currActIcon = icon;
      _currActName = name;
      _activeActivity = true;
    });
    // End timer
    if(timerService.isRunning) {
      timerService.stop();
    }
    // Save time in var
    timerService.reset();
    // Save timer time to whatever data holder
  }

  addActivity(IconData iconData, String name) {
    if (!_namesList.contains(name)) {
      _namesList.add(name);
      setState(() {
        _activityList.add(new ButtonPair(iconData, name));
      });
    }
  }

  addActivityAlert() {

    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.lightBlue,
        ),
      ),
    );

    Alert(
      style: alertStyle,
      context: context,
      title: "Add a new Activity",
      image: Image.asset("assets/plus.png"),
      content: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text("Select Name:"),
          TextField(
            onChanged: (text) {
              _newName = text;
            },
          ),
          SizedBox(height: 20),
          DialogButton(
            onPressed: () {
              showPicker();
            },
            child: Text(
              "Select Icon",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            addActivity(_newIcon.icon, _newName);
            Navigator.pop(context);
          },
          child: Text(
            "ADD ACTIVITY",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  showPicker() {
    Picker(
      adapter: PickerDataAdapter(data: [
        PickerItem(text: Icon(Icons.build), value: Icons.build),
        PickerItem(text: Icon(Icons.music_note), value: Icons.music_note),
        PickerItem(
            text: Icon(Icons.accessibility_new),
            value: Icons.accessibility_new),
        PickerItem(text: Icon(Icons.favorite), value: Icons.favorite),
        PickerItem(
            text: Icon(Icons.favorite_border), value: Icons.favorite_border),
        PickerItem(text: Icon(Icons.face), value: Icons.face),
        PickerItem(text: Icon(Icons.motorcycle), value: Icons.motorcycle),
        PickerItem(text: Icon(Icons.pets), value: Icons.pets),
        PickerItem(text: Icon(Icons.rowing), value: Icons.rowing),
        PickerItem(text: Icon(Icons.mic), value: Icons.mic),
        PickerItem(text: Icon(Icons.mic_none), value: Icons.mic_none),
        PickerItem(
            text: Icon(Icons.supervisor_account),
            value: Icons.supervisor_account),
        PickerItem(text: Icon(Icons.home), value: Icons.home),
        PickerItem(text: Icon(Icons.alarm), value: Icons.alarm),
        PickerItem(text: Icon(Icons.alarm_on), value: Icons.alarm_on),
        PickerItem(text: Icon(Icons.snooze), value: Icons.snooze),
        PickerItem(
            text: Icon(Icons.flight_takeoff), value: Icons.flight_takeoff),
        PickerItem(text: Icon(Icons.explore), value: Icons.explore),
        PickerItem(
            text: Icon(Icons.sentiment_satisfied),
            value: Icons.sentiment_satisfied),
        PickerItem(
            text: Icon(Icons.sentiment_dissatisfied),
            value: Icons.sentiment_dissatisfied),
        PickerItem(text: Icon(Icons.textsms), value: Icons.textsms),
        PickerItem(text: Icon(Icons.gesture), value: Icons.gesture),
        PickerItem(text: Icon(Icons.flag), value: Icons.flag),
        PickerItem(text: Icon(Icons.weekend), value: Icons.weekend),
        PickerItem(text: Icon(Icons.watch), value: Icons.watch),
        PickerItem(text: Icon(Icons.attach_money), value: Icons.attach_money),
        PickerItem(text: Icon(Icons.border_color), value: Icons.border_color),
        PickerItem(text: Icon(Icons.format_paint), value: Icons.format_paint),
        PickerItem(text: Icon(Icons.format_quote), value: Icons.format_quote),
        PickerItem(text: Icon(Icons.insert_photo), value: Icons.insert_photo),
        PickerItem(
            text: Icon(Icons.insert_invitation),
            value: Icons.insert_invitation),
        PickerItem(text: Icon(Icons.text_fields), value: Icons.text_fields),
        PickerItem(text: Icon(Icons.cloud), value: Icons.cloud),
        PickerItem(text: Icon(Icons.gamepad), value: Icons.gamepad),
        PickerItem(text: Icon(Icons.headset), value: Icons.headset),
        PickerItem(text: Icon(Icons.headset_mic), value: Icons.headset_mic),
        PickerItem(text: Icon(Icons.computer), value: Icons.computer),
        PickerItem(text: Icon(Icons.desktop_mac), value: Icons.desktop_mac),
        PickerItem(
            text: Icon(Icons.desktop_windows), value: Icons.desktop_windows),
        PickerItem(text: Icon(Icons.keyboard), value: Icons.keyboard),
        PickerItem(text: Icon(Icons.laptop), value: Icons.laptop),
        PickerItem(
            text: Icon(Icons.laptop_chromebook),
            value: Icons.laptop_chromebook),
        PickerItem(text: Icon(Icons.laptop_mac), value: Icons.laptop_mac),
        PickerItem(text: Icon(Icons.mouse), value: Icons.mouse),
        PickerItem(text: Icon(Icons.phone_android), value: Icons.phone_android),
        PickerItem(text: Icon(Icons.phone_iphone), value: Icons.phone_iphone),
        PickerItem(text: Icon(Icons.speaker), value: Icons.speaker),
        PickerItem(
            text: Icon(Icons.tablet_android), value: Icons.tablet_android),
        PickerItem(text: Icon(Icons.tablet_mac), value: Icons.tablet_mac),
        PickerItem(text: Icon(Icons.toys), value: Icons.toys),
        PickerItem(text: Icon(Icons.tv), value: Icons.tv),
        PickerItem(
            text: Icon(Icons.videogame_asset), value: Icons.videogame_asset),
        PickerItem(text: Icon(Icons.blur_on), value: Icons.blur_on),
        PickerItem(text: Icon(Icons.camera), value: Icons.camera),
        PickerItem(text: Icon(Icons.camera_alt), value: Icons.camera_alt),
        PickerItem(text: Icon(Icons.brush), value: Icons.brush),
        PickerItem(text: Icon(Icons.color_lens), value: Icons.color_lens),
        PickerItem(text: Icon(Icons.colorize), value: Icons.colorize),
        PickerItem(text: Icon(Icons.edit), value: Icons.edit),
        PickerItem(
            text: Icon(Icons.filter_vintage), value: Icons.filter_vintage),
        PickerItem(text: Icon(Icons.flash_on), value: Icons.flash_on),
        PickerItem(text: Icon(Icons.landscape), value: Icons.landscape),
        PickerItem(text: Icon(Icons.looks), value: Icons.looks),
        PickerItem(text: Icon(Icons.nature_people), value: Icons.nature_people),
        PickerItem(text: Icon(Icons.straighten), value: Icons.straighten),
        PickerItem(text: Icon(Icons.whatshot), value: Icons.whatshot),
        PickerItem(text: Icon(Icons.public), value: Icons.public),
        PickerItem(text: Icon(Icons.cake), value: Icons.cake),
        PickerItem(text: Icon(Icons.spa), value: Icons.spa),
        PickerItem(text: Icon(Icons.smoking_rooms), value: Icons.smoking_rooms),
        PickerItem(text: Icon(Icons.pool), value: Icons.pool),
        PickerItem(text: Icon(Icons.kitchen), value: Icons.kitchen),
        PickerItem(text: Icon(Icons.hot_tub), value: Icons.hot_tub),
        PickerItem(text: Icon(Icons.golf_course), value: Icons.golf_course),
        PickerItem(
            text: Icon(Icons.free_breakfast), value: Icons.free_breakfast),
        PickerItem(
            text: Icon(Icons.fitness_center), value: Icons.fitness_center),
        PickerItem(
            text: Icon(Icons.child_friendly), value: Icons.child_friendly),
        PickerItem(text: Icon(Icons.child_care), value: Icons.child_care),
        PickerItem(text: Icon(Icons.casino), value: Icons.casino),
        PickerItem(
            text: Icon(Icons.business_center), value: Icons.business_center),
        PickerItem(text: Icon(Icons.business), value: Icons.business),
        PickerItem(text: Icon(Icons.all_inclusive), value: Icons.all_inclusive),
        PickerItem(
            text: Icon(Icons.airport_shuttle), value: Icons.airport_shuttle),
        PickerItem(text: Icon(Icons.ac_unit), value: Icons.ac_unit),
        PickerItem(text: Icon(Icons.wc), value: Icons.wc),
        PickerItem(text: Icon(Icons.priority_high), value: Icons.priority_high),
        PickerItem(text: Icon(Icons.phone_in_talk), value: Icons.phone_in_talk),
        PickerItem(text: Icon(Icons.drive_eta), value: Icons.drive_eta),
        PickerItem(text: Icon(Icons.refresh), value: Icons.refresh),
        PickerItem(text: Icon(Icons.tram), value: Icons.tram),
        PickerItem(text: Icon(Icons.train), value: Icons.train),
        PickerItem(text: Icon(Icons.traffic), value: Icons.traffic),
        PickerItem(text: Icon(Icons.subway), value: Icons.subway),
        PickerItem(text: Icon(Icons.restaurant), value: Icons.restaurant),
        PickerItem(
            text: Icon(Icons.restaurant_menu), value: Icons.restaurant_menu),
        PickerItem(text: Icon(Icons.place), value: Icons.place),
        PickerItem(text: Icon(Icons.navigation), value: Icons.navigation),
        PickerItem(text: Icon(Icons.map), value: Icons.map),
        PickerItem(text: Icon(Icons.local_taxi), value: Icons.local_taxi),
        PickerItem(
            text: Icon(Icons.local_shipping), value: Icons.local_shipping),
        PickerItem(text: Icon(Icons.local_pizza), value: Icons.local_pizza),
        PickerItem(text: Icon(Icons.local_movies), value: Icons.local_movies),
        PickerItem(text: Icon(Icons.local_florist), value: Icons.local_florist),
        PickerItem(text: Icon(Icons.local_drink), value: Icons.local_drink),
        PickerItem(text: Icon(Icons.local_bar), value: Icons.local_bar),
        PickerItem(text: Icon(Icons.hotel), value: Icons.hotel),
        PickerItem(text: Icon(Icons.fastfood), value: Icons.fastfood),
        PickerItem(
            text: Icon(Icons.directions_walk), value: Icons.directions_walk),
        PickerItem(
            text: Icon(Icons.directions_run), value: Icons.directions_run),
        PickerItem(
            text: Icon(Icons.directions_bus), value: Icons.directions_bus),
        PickerItem(
            text: Icon(Icons.directions_boat), value: Icons.directions_boat),
        PickerItem(
            text: Icon(Icons.directions_bike), value: Icons.directions_bike),
      ]),
      title: new Text("Select Icon"),
      onConfirm: (Picker picker, List value) {
        _newIcon = Icon(picker.getSelectedValues().removeLast());
      },
    ).showDialog(_scaffoldKey.currentContext);
  }
}

class ButtonPair {
  IconData iconData;
  String name;
  ButtonPair(IconData _iconData, String _name) {
    iconData = _iconData;
    name = _name;
  }
}

// String array of names so no name duplicates
// change in dialogue onChanged() textField
