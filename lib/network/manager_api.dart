import 'package:airpollution/configs/app_config.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_interceptors.dart';

class ManagerApi {
  late final Dio dio;
  late final ApiClient apiClient;

  static final ManagerApi instance = ManagerApi._privateConstructor();

  ManagerApi._privateConstructor() {
    dio = Dio();
    dio.options.baseUrl = AppConfig.baseWeatherUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.options.connectTimeout = const Duration(minutes: 3);
    dio.options.receiveTimeout = const Duration(minutes: 3);
    apiClient = ApiClient(dio, baseUrl: AppConfig.baseWeatherUrl);
  }
}
