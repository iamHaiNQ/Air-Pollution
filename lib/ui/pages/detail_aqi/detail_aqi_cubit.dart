import 'package:airpollution/models/data/data_aqi.dart';
import 'package:airpollution/models/data/data_location.dart';
import 'package:airpollution/models/entities/aqi_information_entity.dart';
import 'package:airpollution/models/entities/location_entity.dart';
import 'package:airpollution/models/entities/weather/info_weather_entity.dart';
import 'package:airpollution/models/entities/weather/weather_by_day_entity.dart';
import 'package:airpollution/models/enums/load_status.dart';
import 'package:airpollution/services/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_aqi_state.dart';

class DetailAqiCubit extends Cubit<DetailAqiState> {
  IWeatherRepository? repository;

  DetailAqiCubit({
    this.repository,
  }) : super(const DetailAqiState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(
      loadDataStatus: LoadStatus.initial,
    ));

    try {
      await getWeather();
      emit(state.copyWith(
        listAqiForecast: listAQISample,
        locations: listLocation,
        currentAQI: AQIInformation(
          airQuality: 80,
          o3: 30,
          pm10: 25,
          no: 10,
          no2: 15,
          pm1: 5,
          pm25: 20,
          timeOfDay: '$currentHour:00',
        ),
        loadDataStatus: LoadStatus.success,
      ));
    } catch (e, s) {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
  }

  Future<void> getWeather({
    String address = 'Hà Nội',
  }) async {
    emit(state.copyWith(loadWeatherStatus: LoadStatus.loading));

    try {
      final weatherCurrent = await repository?.getWeatherByCityName(
        address: address,
      );

      final weatherByDay = await repository?.getWeatherByHour(
        lat: "${weatherCurrent?.coord?.lat ?? 0}",
        lon: "${weatherCurrent?.coord?.lon ?? 0}",
        exclude: 'daily',
      );

      emit(
        state.copyWith(
          loadWeatherStatus: LoadStatus.success,
          weatherCurrent: weatherCurrent,
          weatherByDay: weatherByDay,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadWeatherStatus: LoadStatus.failure));
    }
  }
}
