part of 'map_cubit.dart';

class MapState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<LocationEntity>? locations;

  const MapState({
    this.loadDataStatus = LoadStatus.initial,
    this.locations,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        locations,
      ];

  MapState copyWith({
    LoadStatus? loadDataStatus,
    List<LocationEntity>? locations,
  }) {
    return MapState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      locations: locations ?? this.locations,
    );
  }
}
