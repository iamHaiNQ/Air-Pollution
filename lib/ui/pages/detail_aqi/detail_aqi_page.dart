import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/models/entities/location_entity.dart';
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
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: 223,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Weather",
                      style: AppTextStyle.blackS20W700,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Column(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: MapWidget(
                      locations: state.locations,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(
                          21.0278,
                          105.8342,
                        ),
                        zoom: 10,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
