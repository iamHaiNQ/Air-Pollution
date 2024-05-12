import 'package:airpollution/models/enums/aqi_level.dart';

class LocationEntity {
  final double? lat;
  final double? long;
  final String? addressName;
  final int? airQuality;

  LocationEntity({
    this.lat,
    this.long,
    this.addressName,
    this.airQuality,
  });

  AqiLevel get getAqiLevel {
    if (airQuality == null) return AqiLevel.excellent;

    if (airQuality! <= 50) {
      return AqiLevel.excellent;
    } else if (airQuality! <= 100) {
      return AqiLevel.good;
    } else if (airQuality! <= 150) {
      return AqiLevel.fair;
    } else if (airQuality! <= 200) {
      return AqiLevel.poorForSensitiveGroups;
    } else if (airQuality! <= 300) {
      return AqiLevel.unhealthy;
    } else {
      return AqiLevel.veryUnhealthy;
    }
  }
}
