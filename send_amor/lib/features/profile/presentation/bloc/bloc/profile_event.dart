part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateUniqueNameEvent extends ProfileEvent {
  final BuildContext context;
  final AppUser appUser;
  final String uniqueName;
  const UpdateUniqueNameEvent(
      {required this.context, required this.appUser, required this.uniqueName});
}

class FetchUserDetailsEvent extends ProfileEvent {
  final BuildContext context;
  final AppUser appUser;
  const FetchUserDetailsEvent({required this.context, required this.appUser});
}
