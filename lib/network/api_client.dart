import 'package:airpollution/configs/app_config.dart';
import 'package:airpollution/models/entities/weather/info_weather_entity.dart';
import 'package:airpollution/models/entities/weather/weather_by_day_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConfig.baseWeatherUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/data/2.5/weather')
  Future<InfoWeatherEntity> getWeatherByCityName({
    @Query("q") String? address,
    @Query("units") String? units,
    @Query("appid") String? appId,
  });

  @GET('/data/2.5/onecall')
  Future<WeatherByDayEntity> getWeatherByHour({
    @Query("lat") String? lat,
    @Query("lon") String? lon,
    @Query("exclude") String? exclude,
    @Query("units") String? units,
    @Query("appid") String? appId,
  });
}