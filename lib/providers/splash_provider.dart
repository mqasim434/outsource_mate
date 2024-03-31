import 'dart:async';

import 'package:flutter/cupertino.dart';

class SplashProvider extends ChangeNotifier{
  SplashProvider({function}){
    Timer(const Duration(seconds: 3),function);
  }
}
