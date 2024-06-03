import 'package:airpollution/models/entities/account_entity.dart';
import 'package:flutter/material.dart';

class GlobalData {
  GlobalData._privateConstructor();

  static final GlobalData instance = GlobalData._privateConstructor();

  final navigatorKey = GlobalKey<NavigatorState>();

  String? deviceToken;

  AccountEntity? accountEntity;

}
