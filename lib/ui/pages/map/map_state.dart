part of 'map_cubit.dart';

class MapState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<LocationEntity>? locations;
  final bool showDetailLocation;
  final LocationEntity? locationSelected;

  const MapState({
    this.loadDataStatus = LoadStatus.initial,
    this.locations,
    this.locationSelected,
    this.showDetailLocation = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        locations,
        showDetailLocation,
        locationSelected,
      ];

  MapState copyWith({
    LoadStatus? loadDataStatus,
    List<LocationEntity>? locations,
    bool? showDetailLocation,
    LocationEntity? locationSelected,
  }) {
    return MapState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      locations: locations ?? this.locations,
      showDetailLocation: showDetailLocation ?? this.showDetailLocation,
      locationSelected: locationSelected ?? this.locationSelected,
    );
  }
}
