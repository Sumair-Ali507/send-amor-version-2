import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/profile/domain/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(ProfileInitial()) {
    on<UpdateUniqueNameEvent>((event, emit) async {
      try {
        emit(UpdateUniqueNameInProgress());
        AppUser? appUser = await _profileRepository.setUserName(
            context: event.context,
            newUsername: event.uniqueName,
            appUser: event.appUser);
        emit(UpdateUniqueNameSuccess(appUser: appUser));
      } catch (e) {
        debugPrint('Error in FetchAllContactsEvent---${e.toString()}');
        emit(UpdateUniqueNameFailure(e.toString()));
      }
    });

    on<FetchUserDetailsEvent>((event, emit) async {
      try {
        emit(FetchUserDetailInProgress());
        AppUser? appUser = await _profileRepository.fetchUserDetails(
            context: event.context, appUser: event.appUser);
        emit(FetchUserDetailSuccess(appUser: appUser));
      } catch (e) {
        debugPrint('Error in FetchAllContactsEvent---${e.toString()}');
        emit(FetchUserDetailFailure(e.toString()));
      }
    });
  }
}
