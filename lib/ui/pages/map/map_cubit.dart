import 'package:airpollution/models/data/data_location.dart';
import 'package:airpollution/models/entities/location_entity.dart';
import 'package:airpollution/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState());

  Future<void> loadInitialData() async {
    emit(
      state.copyWith(
        loadDataStatus: LoadStatus.initial,
      ),
    );
    try {
      emit(
        state.copyWith(
          locations: listLocation,
          loadDataStatus: LoadStatus.success,
        ),
      );
    } catch (e, s) {
      //Todo: should print exception here
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.failure,
        ),
      );
    }
  }
}
