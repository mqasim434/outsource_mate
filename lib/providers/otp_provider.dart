import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OtpProvider with ChangeNotifier {
  int _otpCount = 10;
  late Timer _timer;

  int get otpCount => _otpCount;

  set otpCount(int value) {
    _otpCount = value;
    notifyListeners();
    startOtpTimer();
  }


  void startOtpTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_otpCount > 0) {
        _otpCount--;
        notifyListeners();
      } else {
        _timer.cancel();
      }
    });
  }

  OtpProvider(){
    startOtpTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
