part of 'detail_aqi_cubit.dart';

class DetailAqiState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus loadWeatherStatus;
  final List<AQIInformation>? listAqiForecast;
  final AQIInformation? currentAQI;
  final List<LocationEntity>? locations;
  final InfoWeatherEntity? weatherCurrent;
  final WeatherByDayEntity? weatherByDay;

  const DetailAqiState({
    this.loadDataStatus = LoadStatus.initial,
    this.loadWeatherStatus = LoadStatus.initial,
    this.weatherByDay,
    this.weatherCurrent,
    this.currentAQI,
    this.listAqiForecast,
    this.locations,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        loadWeatherStatus,
        weatherByDay,
        weatherCurrent,
        currentAQI,
        listAqiForecast,
        locations,
      ];

  DetailAqiState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? loadWeatherStatus,
    InfoWeatherEntity? weatherCurrent,
    WeatherByDayEntity? weatherByDay,
    List<AQIInformation>? listAqiForecast,
    AQIInformation? currentAQI,
    List<LocationEntity>? locations,
  }) {
    return DetailAqiState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      loadWeatherStatus: loadWeatherStatus ?? this.loadWeatherStatus,
      weatherCurrent: weatherCurrent ?? this.weatherCurrent,
      weatherByDay: weatherByDay ?? this.weatherByDay,
      listAqiForecast: listAqiForecast ?? this.listAqiForecast,
      currentAQI: currentAQI ?? this.currentAQI,
      locations: locations ?? this.locations,
    );
  }
}
