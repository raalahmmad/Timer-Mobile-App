import 'dart:async';
import 'dart:io';
import './timermodel.dart';
import 'package:flutter/foundation.dart';

class CountDownTimer with ChangeNotifier {
  int work = 30;
  double _radius = 1;
  bool _isActive = true;
  Timer timer;
  Duration _time = Duration(seconds: 0);
  Duration _fullTime;
  int shortBreak = 5;
  int longBreak = 20;

  TimerModel get getTimer {
    var formatedTime = returnTime(_time);

    return TimerModel(formatedTime, _radius);
  }

  void startBreak(bool isShort) {
    print('Callledd....');
    _radius = 1;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }

  void stopTimer() {
    this._isActive = false;
  }

  void startTimer() {
    if (_time.inSeconds > 0) {
      this._isActive = true;
    }
  }

  void startWork() {
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
    stream().listen((event) {
      notifyListeners();
    });
  }

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  Stream<void> stream() async* {
    //sleep(Duration(seconds: 5));

    //yield* Stream.value(TimerModel('99:99', 0.6));

    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (this._isActive) {
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time);
      //notifyListeners();
      //return TimerModel(time, _radius);
    });
  }
}
