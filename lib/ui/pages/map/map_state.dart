part of 'map_cubit.dart';

class MapState extends Equatable {
  final LoadStatus loadDataStatus;

  const MapState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  MapState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return MapState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
