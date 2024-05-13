import 'package:airpollution/configs/app_config.dart';
import 'package:airpollution/models/entities/weather/info_weather_entity.dart';
import 'package:airpollution/models/entities/weather/weather_by_day_entity.dart';
import 'package:airpollution/network/api_client.dart';

abstract class IWeatherRepository {
  Future<InfoWeatherEntity> getWeatherByCityName({
    String? address,
    String? units,
    String? appId,
  });

  Future<WeatherByDayEntity> getWeatherByHour({
    String? lat,
    String? lon,
    String? exclude,
    String? units,
    String? appId,
  });
}

class WeatherRepository extends IWeatherRepository {
  ApiClient apiClient;

  WeatherRepository(this.apiClient);

  @override
  Future<InfoWeatherEntity> getWeatherByCityName({
    String? address,
    String? units,
    String? appId,
  }) async {
    return await apiClient.getWeatherByCityName(
      address: address,
      units: 'metric',
      appId: AppConfig.apiKey,
    );
  }

  @override
  Future<WeatherByDayEntity> getWeatherByHour({
    String? lat,
    String? lon,
    String? exclude,
    String? units,
    String? appId,
  }) async {
    return await apiClient.getWeatherByHour(
      lat: lat,
      lon: lon,
      exclude: exclude,
      units: 'metric',
      appId: AppConfig.apiKey,
    );
  }
}
