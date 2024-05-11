import 'package:airpollution/ui/components/map_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      zoom: 13,
    );
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
          prev.loadDataStatus != current.loadDataStatus,
      builder: (context, state) {
        return MapWidget(
          initialCameraPosition: kGooglePlex,
          locations: state.locations,
          onTapMarker: (index){

          },
          onTapBackgroundMap: (){

          },
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
