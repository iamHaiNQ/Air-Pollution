import 'package:flutter/material.dart';

enum AqiLevel {
  excellent,
  good,
  fair,
  poorForSensitiveGroups,
  unhealthy,
  veryUnhealthy,
}

extension AppBarTypeExt on AqiLevel {
  Color? get getColor {
    switch (this) {
      case AqiLevel.excellent:
        return Colors.green;
      case AqiLevel.good:
        return Colors.yellow;
      case AqiLevel.fair:
        return Colors.orange;
      case AqiLevel.poorForSensitiveGroups:
        return Colors.red;
      case AqiLevel.unhealthy:
        return Colors.deepPurpleAccent;
      case AqiLevel.veryUnhealthy:
        return Colors.brown;
    }
  }

  String get getTitle {
    switch (this) {
      case AqiLevel.excellent:
        return "Tốt";
      case AqiLevel.good:
        return "Trung bình";
      case AqiLevel.fair:
        return "Không tốt cho nhóm nhạy cảm";
      case AqiLevel.poorForSensitiveGroups:
        return "Có hại cho sức khoẻ";
      case AqiLevel.unhealthy:
        return "Rất có hại cho sức khoẻ";
      case AqiLevel.veryUnhealthy:
        return "Nguy hại ";
    }
  }
}
