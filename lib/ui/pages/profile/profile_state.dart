part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final LoadStatus loadDataStatus;

  const ProfileState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  ProfileState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return ProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
