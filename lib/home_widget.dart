import 'package:flutter/material.dart';
import 'package:time_scribe/History_body_widget.dart';
import 'package:time_scribe/home_body_widget.dart';

class HomePage extends StatefulWidget {
  @override _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Current tab index
  int _currentIndex = 0;
  static HomeBodyWidget _homeBodyWidget = new HomeBodyWidget();
  static HistoryBodyWidget _historyBodyWidget = new HistoryBodyWidget();

  // Widgets we want to render based on the tab (2D Array)
  final List<Widget> _children = [
    _homeBodyWidget, // home_body_widget.dart
    _historyBodyWidget, // History_body_widget.dart
  ];

  // Set _currentIndex to index tapped in bottom nav bar
  void onTabTapped(int index) {
    setState( () {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('Time Scribe')
      ),
      // Body is the children being rendered based on selected tab
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        // the index of the active tab
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem (
            icon: new Icon(Icons.alarm_add),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem (
            icon: new Icon(Icons.history),
            title: new Text('History'),
          ),
        ]
      ),
    );
  }
}
