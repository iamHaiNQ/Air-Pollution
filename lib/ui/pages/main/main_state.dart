part of 'main_cubit.dart';

class MainState extends Equatable {
  final LoadStatus loadDataStatus;

  const MainState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  MainState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return MainState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
