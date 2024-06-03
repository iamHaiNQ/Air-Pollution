part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  final LoadStatus loadDataStatus;

  const SignUpState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
    loadDataStatus,
  ];

  SignUpState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return SignUpState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
