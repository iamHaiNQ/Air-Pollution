import 'package:airpollution/commons/app_vectors.dart';
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
          level: 1,
          min: 0,
          max: 50,
          title: "Tốt",
          description: "",
          imgLink: "",
          backgroundColor: Colors.green,
        );
      case AqiLevel.good:
        return HealthLevelInfoEntity(
          level: 2,
          min: 51,
          max: 100,
          title: "Trung bình",
          description: "",
          imgLink: "",
          backgroundColor: Colors.yellow,
        );
      case AqiLevel.fair:
        return HealthLevelInfoEntity(
          level: 3,
          min: 101,
          max: 150,
          title: "Không tốt cho nhóm nhạy cảm",
          description: "",
          imgLink: "",
          backgroundColor: Colors.orange,
        );
      case AqiLevel.poorForSensitiveGroups:
        return HealthLevelInfoEntity(
          level: 4,
          min: 151,
          max: 200,
          title: "Có hại cho sức khoẻ",
          description: "",
          imgLink: "",
          backgroundColor: Colors.red,
        );
      case AqiLevel.unhealthy:
        return HealthLevelInfoEntity(
          level: 5,
          min: 201,
          max: 300,
          title: "Rất có hại cho sức khoẻ",
          description: "",
          imgLink: "",
          backgroundColor: Colors.deepPurpleAccent,
        );
      case AqiLevel.veryUnhealthy:
        return HealthLevelInfoEntity(
          level: 5,
          min: 301,
          max: 500,
          title: "Nguy hại",
          description: "",
          imgLink: "",
          backgroundColor: Colors.brown,
        );
    }
  }

  String get getIconStatus {
    switch (this) {
      case AqiLevel.excellent:
        return AppVectors.iconAqiLevel1;
      case AqiLevel.good:
        return AppVectors.iconAqiLevel2;
      case AqiLevel.fair:
        return AppVectors.iconAqiLevel3;
      case AqiLevel.poorForSensitiveGroups:
        return AppVectors.iconAqiLevel4;
      case AqiLevel.unhealthy:
        return AppVectors.iconAqiLevel5;
      case AqiLevel.veryUnhealthy:
        return AppVectors.iconAqiLevel6;
      default:
        return AppVectors.iconAqiLevel1;
    }
  }
}
