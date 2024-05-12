part of 'detail_aqi_cubit.dart';

class DetailAqiState extends Equatable {
  final LoadStatus loadDataStatus;

  const DetailAqiState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  DetailAqiState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return DetailAqiState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
