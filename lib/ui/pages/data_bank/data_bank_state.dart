part of 'data_bank_cubit.dart';

class DataBankState extends Equatable {
  final LoadStatus loadDataStatus;
  List<File>? images;
  String? populationType;
  String? populationLevel;

  DataBankState({
    this.loadDataStatus = LoadStatus.initial,
    this.images,
    this.populationLevel,
    this.populationType,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        images,
        populationLevel,
        populationType,
      ];

  DataBankState copyWith({
    LoadStatus? loadDataStatus,
    List<File>? images,
    String? populationType,
    String? populationLevel,
  }) {
    return DataBankState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      images: images ?? this.images,
      populationType: populationType ?? this.populationType,
      populationLevel: populationLevel ?? this.populationLevel,
    );
  }
}
