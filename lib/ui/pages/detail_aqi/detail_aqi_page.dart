import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/models/entities/location_entity.dart';
import 'package:airpollution/models/entities/weather/current_entity.dart';
import 'package:airpollution/services/weather_repository.dart';
import 'package:airpollution/ui/components/map_widget.dart';
import 'package:airpollution/ui/pages/detail_aqi/widgets/aqi_quality_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'detail_aqi_cubit.dart';

class DetailAqiArguments {
  final LocationEntity location;

  DetailAqiArguments({
    required this.location,
  });
}

class DetailAqiPage extends StatelessWidget {
  final DetailAqiArguments arguments;

  const DetailAqiPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = RepositoryProvider.of<IWeatherRepository>(context);
        return DetailAqiCubit(
          repository: repository,
        );
      },
      child: DetailAqiChildPage(
        arguments: arguments,
      ),
    );
  }
}

class DetailAqiChildPage extends StatefulWidget {
  final DetailAqiArguments arguments;

  const DetailAqiChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<DetailAqiChildPage> createState() => _DetailAqiChildPageState();
}

class _DetailAqiChildPageState extends State<DetailAqiChildPage> {
  late final DetailAqiCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorGrayBackground,
        title: Text("${widget.arguments.location.addressName}"),
        elevation: 0,
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<DetailAqiCubit, DetailAqiState>(
      buildWhen: (prev, current) =>
          prev.loadDataStatus != current.loadDataStatus,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AqiQualityCard(
                listAqiForecast: state.listAqiForecast,
                currentAQI: state.currentAQI,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: 240,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Weather",
                      style: AppTextStyle.blackS20W700,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Now",
                                  style: AppTextStyle.blackS10.copyWith(
                                    color: Colors.black.withOpacity(0.72),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    state.weatherCurrent?.weather![0]
                                            .description ??
                                        '',
                                    style: AppTextStyle.blackS16W500,
                                  ),
                                ),
                                Text(
                                  "Feels like ${state.weatherByDay?.current?.feelsLike ?? 0}°C",
                                  style: AppTextStyle.blackS10.copyWith(
                                    color: Colors.black.withOpacity(0.72),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${state.weatherCurrent?.main?.temp ?? 0}",
                                style: AppTextStyle.blackS24W700,
                              ),
                              Text(
                                "°C",
                                style: AppTextStyle.blackS14.copyWith(
                                  color: Colors.black.withOpacity(0.72),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Image.network(
                            'https://openweathermap.org/img/wn/${state.weatherCurrent?.weather![0].icon ?? ''}@2x.png',
                            height: 48,
                            width: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 100,
                      child: ListView.separated(
                        itemCount: state.weatherByDay?.hourly?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 4),
                        itemBuilder: (context, index) {
                          final weather = state.weatherByDay?.hourly?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              height: 72,
                              width: 43,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    weather?.dateTime ?? '',
                                    style: AppTextStyle.blackS10,
                                  ),
                                  const SizedBox(height: 4),
                                  Image.network(
                                    'https://openweathermap.org/img/wn/${weather?.weather?[0].icon ?? ''}@2x.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${weather?.getTemp ?? 0}",
                                        style: AppTextStyle.blackS14W500,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          "°C",
                                          style: AppTextStyle.blackS10.copyWith(
                                            fontSize: 8,
                                            color:
                                                Colors.black.withOpacity(0.72),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildMapWidget(state.locations),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMapWidget(
    List<LocationEntity>? locations,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Show on Map",
          style: AppTextStyle.blackS12.copyWith(
            color: Colors.black.withOpacity(0.72),
          ),
        ),
        Container(
          height: 160,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: MapWidget(
              locations: locations,
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  21.0278,
                  105.8342,
                ),
                zoom: 10,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
