import 'package:airpollution/models/enums/aqi_level.dart';

class AQIInformation {
  final int? airQuality;
  final int? o3;
  final int? pm10;
  final int? no;
  final int? no2;
  final int? pm1;
  final int? pm25;
  final String? timeOfDay;

  AQIInformation({
    this.airQuality,
    this.o3,
    this.pm10,
    this.no,
    this.no2,
    this.pm1,
    this.pm25,
    this.timeOfDay,
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
