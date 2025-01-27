import 'package:airpollution/models/entities/aqi_information_entity.dart';

DateTime currentTime = DateTime.now();
int currentHour = currentTime.hour % 24;

List<AQIInformation> listAQISample = [
  AQIInformation(
    airQuality: 105,
    o3: 35,
    pm10: 28,
    no: 12,
    no2: 18,
    pm1: 6,
    pm25: 22,
    timeOfDay: '${currentHour + 1}:00',
  ),
  AQIInformation(
    airQuality: 168,
    o3: 25,
    pm10: 20,
    no: 8,
    no2: 12,
    pm1: 4,
    pm25: 18,
    timeOfDay: '${currentHour + 2}:00',
  ),
  AQIInformation(
    airQuality: 237,
    o3: 20,
    pm10: 18,
    no: 7,
    no2: 10,
    pm1: 3,
    pm25: 15,
    timeOfDay: '${currentHour + 3}:00',
  ),
  AQIInformation(
    airQuality: 278,
    o3: 32,
    pm10: 27,
    no: 11,
    no2: 16,
    pm1: 5,
    pm25: 21,
    timeOfDay: '${currentHour + 4}:00',
  ),
  AQIInformation(
    airQuality: 355,
    o3: 28,
    pm10: 22,
    no: 9,
    no2: 14,
    pm1: 4,
    pm25: 19,
    timeOfDay: '${currentHour + 5}:00',
  ),
  AQIInformation(
    airQuality: 40,
    o3: 33,
    pm10: 26,
    no: 10,
    no2: 16,
    pm1: 5,
    pm25: 20,
    timeOfDay: '${currentHour + 6}:00',
  ),
  AQIInformation(
    airQuality: 90,
    o3: 33,
    pm10: 26,
    no: 10,
    no2: 16,
    pm1: 5,
    pm25: 20,
    timeOfDay: '${currentHour + 7}:00',
  ),
];
