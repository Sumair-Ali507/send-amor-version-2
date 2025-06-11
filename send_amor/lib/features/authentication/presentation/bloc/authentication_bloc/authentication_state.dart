part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class GoogleAuthenticateInProgress extends AuthenticationState {}

final class GoogleAuthenticateSuccess extends AuthenticationState {
  final GoogleAuthResultModel googleAuthResultModel;
  GoogleAuthenticateSuccess(this.googleAuthResultModel);
}

final class GoogleAuthenticateFailure extends AuthenticationState {
  final String? error;
  GoogleAuthenticateFailure(this.error);
}
