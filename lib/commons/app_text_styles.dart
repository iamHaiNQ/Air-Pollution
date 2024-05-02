import 'package:flutter/material.dart';

class AppTextStyle {
  ///Black
  static const black = TextStyle(color: Colors.black);

  //s12
  static final blackS12 = black.copyWith(
    fontSize: 12,
  );

  static final blackS12Bold = blackS12.copyWith(
    fontWeight: FontWeight.bold,
  );

  //s14
  static final blackS14 = black.copyWith(
    fontSize: 14,
  );
  static final blackS14Bold = blackS14.copyWith(
    fontWeight: FontWeight.bold,
  );
  static final blackS14W800 = blackS14.copyWith(
    fontWeight: FontWeight.w800,
  );
}
