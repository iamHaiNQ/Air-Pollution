import 'package:dio/dio.dart';

class ErrorUtils {
  static String networkErrorToMessage(dynamic e) {
    try {
      if (e is DioException) {
        if (e == DioException.connectionTimeout ||
            e == DioException.receiveTimeout ||
            e == DioException.sendTimeout) {
          return "Đã xảy ra lỗi kết nối!";
        }
        if (e.response?.data is Map<String, dynamic>) {
          if (e.response?.data['errors'] != null) {
            return e.response!.data['errors'];
          }
        }
        if (e.response != null && e.response!.statusCode! > 500) {
          return 'Lỗi hệ thống';
        }

        if (e.response != null && e.response!.statusCode == 403) {
          return 'Bạn không có quyền thao tác';
        }
      }
    } catch (e1) {
      return "Đã có lỗi xảy ra!";
    }
    return "Đã có lỗi xảy ra!";
  }
}
