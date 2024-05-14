import 'package:airpollution/commons/app_images.dart';
import 'package:airpollution/ui/components/text_field_widget.dart';
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
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    contentController = TextEditingController();
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset(
            AppImages.imgEarthGreen,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: <Widget>[
                TextFieldWidget(
                  controller: contentController,
                  labelText: "Nội dung",
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
