import 'package:airpollution/commons/app_colors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static Future<void> showInfo(
    BuildContext context, {
    String? title,
    String? message,
    String? icon,
    Function? onTap,
  }) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: title ?? '',
      message: message ?? '',
      backgroundColor: Colors.blue,
      messageColor: Colors.white,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      borderRadius: BorderRadius.circular(5),
      duration: const Duration(seconds: 2),
      onTap: (dynamic) {
        onTap?.call();
      },
    ).show(context);
  }

  static Future<void> showWarning(
    BuildContext context, {
    String? title,
    String? message,
  }) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: title ?? "Có lỗi xảy ra",
      message: message ?? '',
      backgroundColor: Colors.amber,
      messageColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      borderRadius: BorderRadius.circular(5),
    ).show(context);
  }
}
