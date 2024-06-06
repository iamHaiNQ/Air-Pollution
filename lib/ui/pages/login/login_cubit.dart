import 'package:airpollution/models/enums/load_status.dart';
import 'package:airpollution/services/auth_service.dart';
import 'package:airpollution/services/share_preferences_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  AuthService authService = AuthService();

  Future<bool?> onLogin({
    String? userName,
    String? password,
    bool? isRemember,
  }) async {
    try {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.loading,
      ));

      final result = await authService.loginWithEmail(
        email: userName ?? '',
        password: password ?? '',
      );

      if (result != null) {
        emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
        ));
        return true;
      }
    } catch (e) {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
    return null;
  }
}
