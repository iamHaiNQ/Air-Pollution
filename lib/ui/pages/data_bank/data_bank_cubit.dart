import 'dart:io';

import 'package:airpollution/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'data_bank_state.dart';

class DataBankCubit extends Cubit<DataBankState> {
  DataBankCubit() : super(const DataBankState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e, s) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void addImage(
    File imageSelected,
  ) {
    final image = List<File>.of(state.images ?? []);
    image.add(imageSelected);

    emit(
      state.copyWith(
        images: image,
      ),
    );
  }
}
