import 'package:airpollution/commons/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  ///Black
  static const black = TextStyle(color: Colors.black);
  static const textPrimary = TextStyle(color: AppColors.colorTextPrimary);
  static const textAccentBlue = TextStyle(color: AppColors.colorAccentBlue);

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

  static final textPrimaryS14 = textPrimary.copyWith(
    fontSize: 14,
  );

  static final textPrimaryS56Bold = textPrimary.copyWith(
    fontSize: 56,
    fontWeight: FontWeight.bold,
  );

  //s10
  static final textAccentBlueS10 = textAccentBlue.copyWith(
    fontSize: 10,
  );

  static final blackS10 = black.copyWith(
    fontSize: 10,
  );
}
