import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/models/entities/location_entity.dart';
import 'package:airpollution/models/enums/aqi_level.dart';
import 'package:airpollution/ui/components/map_widget.dart';
import 'package:airpollution/ui/pages/detail_aqi/detail_aqi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'map_cubit.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MapCubit();
      },
      child: const MapChildPage(),
    );
  }
}

class MapChildPage extends StatefulWidget {
  const MapChildPage({Key? key}) : super(key: key);

  @override
  State<MapChildPage> createState() => _MapChildPageState();
}

class _MapChildPageState extends State<MapChildPage> {
  late final MapCubit _cubit;
  late CameraPosition kGooglePlex;
  LocationData? currentLocation;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    kGooglePlex = const CameraPosition(
      target: LatLng(
        21.0278,
        105.8342,
      ),
      zoom: 11,
    );
    _fetchCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (prev, current) =>
          prev.loadDataStatus != current.loadDataStatus ||
          prev.showDetailLocation != current.showDetailLocation ||
          prev.locationSelected != current.locationSelected,
      builder: (context, state) {
        return Stack(
          children: [
            MapWidget(
              initialCameraPosition: kGooglePlex,
              locations: state.locations,
              onMapCreated: (controller) {
                mapController = controller;
              },
              onTapMarker: (index) {
                _cubit.onSelectLocation(index);
              },
              onTapBackgroundMap: () {
                _cubit.hideInfoLocation();
              },
            ),
            Positioned(
              left: 16,
              bottom: 30,
              child: InkWell(
                onTap: () {
                  _goToCurrentLocation();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.location_searching,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            if (state.showDetailLocation) ...[
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: _buildLocationInfo(
                  state.locationSelected!,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  _buildLocationInfo(LocationEntity location) {
    final aqiInfo = location.getAqiLevel.getInfo;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAqiPage(
              arguments: DetailAqiArguments(
                location: location,
              ),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Text(
                location.addressName ?? '',
                style: AppTextStyle.textPrimaryS14,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: aqiInfo.backgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Icon(
                      Icons.face,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          Text(
                            "${location.airQuality}",
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "AQI",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      aqiInfo.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _fetchCurrentLocation() async {
    final location = Location();
    try {
      final userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _goToCurrentLocation() {
    if (currentLocation != null && mapController != null) {
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            currentLocation?.latitude ?? 0.0,
            currentLocation?.longitude ?? 0.0,
          ),
          13,
        ),
      );
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
