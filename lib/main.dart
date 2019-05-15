import 'package:flutter/material.dart';
import 'package:time_scribe/home_widget.dart';
import 'dart:async';

///  [References]
///  https://willowtreeapps.com/ideas/how-to-use-flutter-to-build-an-app-with-bottom-navigation
///  https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/#8
///  https://github.com/bizz84/stopwatch-flutter/blob/master/lib/timer_page.dart
///  https://stackoverflow.com/questions/53228993/how-to-implement-persistent-stopwatch-in-flutter
///  https://github.com/RatelHub/rflutter_alert
///  https://flutter.dev/docs/development/ui/interactive
///  https://stackoverflow.com/questions/44489804/show-hide-widgets-on-flutter-programmatically
///  https://stackoverflow.com/questions/49713189/how-to-use-conditional-statement-within-child-attribute-of-a-flutter-widget-cen

void main() {
  final timerService = TimerService();
  runApp(
    TimerServiceProvider(
      service: timerService,
      child: TimeScribe(),
    ),
  );
}

class TimerService extends ChangeNotifier {
  // Stopwatch
  Stopwatch _watch;
  Timer _timer;

  // currentDuration w/ getter (starts at 0)
  Duration get currentDuration => _currentDuration;
  Duration _currentDuration = Duration.zero;

  // Running if timer isn't null
  bool get isRunning => _timer != null;

  // Constructor initializes Stopwatch
  TimerService() {
    _watch = Stopwatch();
  }

  // Callback called every second when TimerService is started
  void _onTick(Timer timer) {
    _currentDuration = _watch.elapsed;
    notifyListeners();
  }

  void start() {
    if(_timer != null) return;
    // Call _onTick every second
    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _watch.start();
    notifyListeners();
  }

  // Cancel and free timer, stop stopwatch
  void stop() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _currentDuration = _watch.elapsed;
    notifyListeners();
  }

  // Call stop() & reset stopwatch and set current duration to 0
  void reset() {
    stop();
    _watch.reset();
    _currentDuration = Duration.zero;
    notifyListeners();
  }


  static TimerService of(BuildContext context) {
    var provider = context.inheritFromWidgetOfExactType(TimerServiceProvider) as TimerServiceProvider;
    return provider.service;
  }

}

class TimerServiceProvider extends InheritedWidget {
  const TimerServiceProvider({Key key, this.service, Widget child}) : super(key: key, child: child);

  final TimerService service;

  @override
  bool updateShouldNotify(TimerServiceProvider old) => service != old.service;
}

class TimeScribe extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Scribe',
      home: HomePage(), // home_widget.dart
    );
  }
}

