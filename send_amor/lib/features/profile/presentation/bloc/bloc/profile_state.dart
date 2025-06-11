part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class UpdateUniqueNameInProgress extends ProfileState {}

final class UpdateUniqueNameSuccess extends ProfileState {
  final AppUser? appUser;
  const UpdateUniqueNameSuccess({required this.appUser});
}

final class UpdateUniqueNameFailure extends ProfileState {
  final String? error;
  const UpdateUniqueNameFailure(this.error);
}

final class FetchUserDetailInProgress extends ProfileState {}

final class FetchUserDetailSuccess extends ProfileState {
  final AppUser? appUser;
  const FetchUserDetailSuccess({required this.appUser});
}

final class FetchUserDetailFailure extends ProfileState {
  final String? error;
  const FetchUserDetailFailure(this.error);
}
