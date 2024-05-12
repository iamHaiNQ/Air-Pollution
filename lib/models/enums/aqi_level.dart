import 'package:airpollution/models/entities/health_level_info_entity.dart';
import 'package:flutter/material.dart';

enum AqiLevel {
  excellent,
  good,
  fair,
  poorForSensitiveGroups,
  unhealthy,
  veryUnhealthy,
}

extension AqiLevelExtension on AqiLevel {
  HealthLevelInfoEntity get getInfo {
    switch (this) {
      case AqiLevel.excellent:
        return HealthLevelInfoEntity(
          min: 0,
          max: 50,
          title: "Tốt",
          description: "",
          imgLink: "",
          backgroundColor: Colors.green,
        );
      case AqiLevel.good:
        return HealthLevelInfoEntity(
          min: 51,
          max: 100,
          title: "Trung bình",
          description: "",
          imgLink: "",
          backgroundColor: Colors.yellow,
        );
      case AqiLevel.fair:
        return HealthLevelInfoEntity(
          min: 101,
          max: 150,
          title: "Không tốt cho nhóm nhạy cảm",
          description: "",
          imgLink: "",
          backgroundColor: Colors.orange,
        );
      case AqiLevel.poorForSensitiveGroups:
        return HealthLevelInfoEntity(
          min: 151,
          max: 200,
          title: "Có hại cho sức khoẻ",
          description: "",
          imgLink: "",
          backgroundColor: Colors.red,
        );
      case AqiLevel.unhealthy:
        return HealthLevelInfoEntity(
          min: 201,
          max: 300,
          title: "Rất có hại cho sức khoẻ",
          description: "",
          imgLink: "",
          backgroundColor: Colors.deepPurpleAccent,
        );
      case AqiLevel.veryUnhealthy:
        return HealthLevelInfoEntity(
          min: 301,
          max: 500,
          title: "Nguy hại",
          description: "",
          imgLink: "",
          backgroundColor: Colors.brown,
        );
    }
  }
}
