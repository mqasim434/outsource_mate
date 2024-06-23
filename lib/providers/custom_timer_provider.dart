import 'dart:async';
import 'package:flutter/material.dart';

class CustomTimerProvider with ChangeNotifier {
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  Timer? _timer;
  final StreamController<dynamic> _streamController =
      StreamController<dynamic>.broadcast();

  int get days => _days;
  int get hours => _hours;
  int get minutes => _minutes;
  int get seconds => _seconds;

  Stream<dynamic> get timerStream => _streamController.stream;

  void setTime({
    required int days,
    required int hours,
    required int minutes,
    required int seconds,
  }) {
    _days = days;
    _hours = hours;
    _minutes = minutes;
    _seconds = seconds;

    _streamController.add(null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void startTimer() {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_days == 0 && _hours == 0 && _minutes == 0 && _seconds == 0) {
        timer.cancel();
        _timer = null;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
        return;
      }

      if (_seconds > 0) {
        _seconds--;
      } else if (_minutes > 0) {
        _seconds = 59;
        _minutes--;
      } else if (_hours > 0) {
        _seconds = 59;
        _minutes = 59;
        _hours--;
      } else if (_days > 0) {
        _seconds = 59;
        _minutes = 59;
        _hours = 23;
        _days--;
      }

      _streamController.add(null);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    });
  }

  void stopTimer() {
    if (_timer == null) {
      return;
    }

    _timer!.cancel();
    _timer = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamController.close();

    super.dispose();
  }
}
