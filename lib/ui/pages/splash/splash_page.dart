import 'dart:io';

import 'package:airpollution/commons/app_vectors.dart';
import 'package:airpollution/configs/global_data.dart';
import 'package:airpollution/ui/pages/main/main_page.dart';
import 'package:airpollution/ui/pages/onboarding/onboarding_page.dart';
import 'package:airpollution/utils/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import 'splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashCubit();
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({Key? key}) : super(key: key);

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late final SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _initApp();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    });
  }

  Future<void> _initApp() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.requestPermission();
      } else {
        await Permission.notification.isDenied.then((value) {
          if (value) {
            Permission.notification.request();
          }
        });
      }

      final deviceToken = await FirebaseMessaging.instance.getToken();
      GlobalData.instance.deviceToken = deviceToken;
      logger.d('Firebase Device TOKEN:\n$deviceToken');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF49fcfa),
              Color(0xFF45d6fd),
            ],
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            AppVectors.iconAirQI,
            width: 30,
            height: 70,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
