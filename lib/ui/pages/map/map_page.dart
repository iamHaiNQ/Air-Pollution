import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_cubit.dart';

class MapArguments {
  String param;

  MapArguments({
    required this.param,
  });
}

class MapPage extends StatelessWidget {
  final MapArguments arguments;

  const MapPage({
    Key? key,
    required this.arguments,
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

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    kGooglePlex = const CameraPosition(
      target: LatLng(0, 0),
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      zoomControlsEnabled: true,
      compassEnabled: true,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: true,
      initialCameraPosition: kGooglePlex,
      onMapCreated: (GoogleMapController controller) {},
      // markers: <Marker>{maker},
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
        ..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
