import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_bank_cubit.dart';

class DataBankPage extends StatelessWidget {
  const DataBankPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DataBankCubit();
      },
      child: const DataBankChildPage(),
    );
  }
}

class DataBankChildPage extends StatefulWidget {
  const DataBankChildPage({Key? key}) : super(key: key);

  @override
  State<DataBankChildPage> createState() => _DataBankChildPageState();
}

class _DataBankChildPageState extends State<DataBankChildPage> {
  late final DataBankCubit _cubit;

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
