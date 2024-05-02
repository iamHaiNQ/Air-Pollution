import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return MapCubit(
        );
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

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
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
    return Container();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
