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
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.failure,
        ),
      );
    }
  }

  onSelectLocation(int index) {
    final location = state.locations![index];
    emit(
      state.copyWith(
        locationSelected: location,
        showDetailLocation: true,
      ),
    );
  }

  void hideInfoLocation() {
    emit(
      state.copyWith(
        showDetailLocation: false,
      ),
    );
  }
}
