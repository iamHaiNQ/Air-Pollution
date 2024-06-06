import 'dart:io';

import 'package:airpollution/configs/global_data.dart';
import 'package:airpollution/models/entities/feedback_entity.dart';
import 'package:airpollution/models/enums/load_status.dart';
import 'package:airpollution/services/feedback_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'data_bank_state.dart';

class DataBankCubit extends Cubit<DataBankState> {
  DataBankCubit() : super(DataBankState());
  FeedbackService feedbackService = FeedbackService();

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

  void changePopulationType(String type) {
    emit(state.copyWith(
      populationType: type,
    ));
  }

  void changePopulationLevel(String level) {
    emit(state.copyWith(
      populationLevel: level,
    ));
  }

  Future<bool?> createFeedback({
    String? address,
    String? populationType,
    String? populationLevel,
    String? content,
  }) async {
    emit(
      state.copyWith(
        loadDataStatus: LoadStatus.loading,
      ),
    );

    try {
      final feedback = FeedbackEntity(
        address: address,
        content: content,
        populationType: state.populationType,
        populationLevel: state.populationLevel,
        email: GlobalData.instance.accountEntity?.email,
        userName: GlobalData.instance.accountEntity?.fullName,
      );

      final result = await feedbackService.createFeedBack(
        feedback: feedback,
      );

      return result;
    } catch (e) {
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.failure,
        ),
      );
    }
    return null;
  }

  resetData() {
    emit(state.copyWith(
      populationType: null,
      populationLevel: null,
      images: null,
    ));

    state.populationLevel = null;
    state.populationType = null;
    state.images = null;
  }
}
