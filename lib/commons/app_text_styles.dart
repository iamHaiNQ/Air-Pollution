import 'package:airpollution/commons/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  ///Black
  static const black = TextStyle(color: Colors.black);
  static const textPrimary = TextStyle(color: AppColors.colorTextPrimary);
  static const textAccentBlue = TextStyle(color: AppColors.colorAccentBlue);

  static const textOnboarding = TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.3,
      letterSpacing: 0.5,
      color: Color(0xff111827));
  static const textOnboarding1 = TextStyle(
      fontFamily: 'SF PRO Display',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xff4b5563));
  static const textButtonStart = TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 24,
      letterSpacing: 0.5,
      color: Colors.black);

  //s12
  static final blackS12 = black.copyWith(
    fontSize: 12,
  );

  static final blackS12Bold = blackS12.copyWith(
    fontWeight: FontWeight.bold,
  );

  static final blackS12W500 = black.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
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

  static final blackS20W700 = blackS14.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  //s16
  static final blackS16W500 = black.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final textPrimaryS14 = textPrimary.copyWith(
    fontSize: 14,
  );

  static final textPrimaryS56Bold = textPrimary.copyWith(
    fontSize: 56,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  //s10
  static final textAccentBlueS10 = textAccentBlue.copyWith(
    fontSize: 10,
  );

  static final blackS10 = black.copyWith(
    fontSize: 10,
  );
  static final textSplash = black.copyWith(
    fontWeight: FontWeight.w200,
  );

  static const _baseTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final TextStyle body1Regular = _baseTextStyle.copyWith(
    fontSize: 16,
  );

  static final TextStyle body3Regular = _baseTextStyle.copyWith(
    fontSize: 13,
  );

  static final TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 12,
  );
}
