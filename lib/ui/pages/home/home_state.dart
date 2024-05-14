part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<LocationEntity>? locations;

  const HomeState({
    this.loadDataStatus = LoadStatus.initial,
    this.locations,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        locations,
      ];

  HomeState copyWith({
    LoadStatus? loadDataStatus,
    List<LocationEntity>? locations,
  }) {
    return HomeState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      locations: locations ?? this.locations,
    );
  }
}
