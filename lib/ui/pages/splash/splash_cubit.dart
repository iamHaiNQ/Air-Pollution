import 'dart:convert';

import 'package:airpollution/configs/global_data.dart';
import 'package:airpollution/models/entities/account_entity.dart';
import 'package:airpollution/models/enums/load_status.dart';
import 'package:airpollution/services/share_preferences_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(
      loadDataStatus: LoadStatus.initial,
    ));
    try {
      final userName = await SharedPreferencesStorage.getUser();

      GlobalData.instance.accountEntity = AccountEntity(
        fullName: userName,
      );
      emit(state.copyWith(
        loadDataStatus: LoadStatus.success,
      ));
    } catch (e, s) {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
  }
}
