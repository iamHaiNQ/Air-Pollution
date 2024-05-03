part of 'data_bank_cubit.dart';

class DataBankState extends Equatable {
  final LoadStatus loadDataStatus;

  const DataBankState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  DataBankState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return DataBankState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
