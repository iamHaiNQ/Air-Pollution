part of 'data_bank_cubit.dart';

class DataBankState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<File>? images;

  const DataBankState({
    this.loadDataStatus = LoadStatus.initial,
    this.images,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        images,
      ];

  DataBankState copyWith({
    LoadStatus? loadDataStatus,
    List<File>? images,
  }) {
    return DataBankState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      images: images ?? this.images,
    );
  }
}
