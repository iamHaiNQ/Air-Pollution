import 'package:airpollution/models/enums/load_status.dart';
import 'package:airpollution/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());
  AuthService authService = AuthService();

  Future onSignUp({
    String? userName,
    String? email,
    String? password,
  }) async {
    emit(state.copyWith(
      loadDataStatus: LoadStatus.loading,
    ));

    try {
      final result = await authService.signUpWithEmail(
        password: password ?? '',
        fullName: userName ?? '',
        email: email ?? '',
        gender: 0,
        phone: "",
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
  }
}
