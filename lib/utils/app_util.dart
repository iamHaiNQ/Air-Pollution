import 'package:airpollution/configs/global_data.dart';
import 'package:flutter/material.dart';

class AppUtil {
  static void dismissKeyboard() {
    FocusScope.of(GlobalData.instance.navigatorKey.currentContext!)
        .requestFocus(
      FocusNode(),
    );
  }
}
