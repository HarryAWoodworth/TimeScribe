import 'package:flutter/material.dart';
import 'package:time_scribe/home_widget.dart';

///  [References]
///  https://willowtreeapps.com/ideas/how-to-use-flutter-to-build-an-app-with-bottom-navigation
///  https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/#8

void main() => runApp(TimeScribe());

class TimeScribe extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Scribe',
      home: HomePage(),
    );
  }
}

