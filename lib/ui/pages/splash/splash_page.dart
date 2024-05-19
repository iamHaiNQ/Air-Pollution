
import 'package:airpollution/commons/app_vectors.dart';
import 'package:airpollution/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
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
