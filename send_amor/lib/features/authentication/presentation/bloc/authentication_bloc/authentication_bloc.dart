import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/google_auth_result_model.dart';
import '../../../domain/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository                = authenticationRepository,
        super(AuthenticationInitial()) {
    on<GoogleAuthenticateEvent>((event, emit) async {
      try {
        emit(GoogleAuthenticateInProgress());
        // GoogleAuthResultModel googleAuthResultModel =
        //     await _authenticationRepository.authenticateWithGoogle(
        //         context: event.context);
        // emit(GoogleAuthenticateSuccess(googleAuthResultModel));
      } catch (e) {
        debugPrint('Error in FetchAllContactsEvent---${e.toString()}');
        emit(GoogleAuthenticateFailure(e.toString()));
      }
    });
  }
}
