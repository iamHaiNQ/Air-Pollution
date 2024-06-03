import 'package:airpollution/blocs/app_cubit.dart';
import 'package:airpollution/configs/global_data.dart';
import 'package:airpollution/network/api_client.dart';
import 'package:airpollution/network/manager_api.dart';
import 'package:airpollution/services/auth_service.dart';
import 'package:airpollution/services/fire_store_service.dart';
import 'package:airpollution/services/weather_repository.dart';
import 'package:airpollution/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLifecycleState state;
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ManagerApi.instance.apiClient;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IWeatherRepository>(create: (context) {
          return WeatherRepository(_apiClient);
        }),
        RepositoryProvider<AuthService>(create: (context) {
          return AuthService();
        }),
        RepositoryProvider<FireStoreService>(create: (context) {
          return FireStoreService();
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => context.read<AppCubit>(),
          )
        ],
        child: MaterialApp(
          title: 'AirQI App',
          navigatorKey: GlobalData.instance.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    this.state = state;
  }
}
