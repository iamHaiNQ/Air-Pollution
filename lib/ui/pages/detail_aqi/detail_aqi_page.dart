import 'package:airpollution/models/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return DetailAqiCubit();
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
