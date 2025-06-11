part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class GoogleAuthenticateEvent extends AuthenticationEvent {
  final BuildContext context;
  GoogleAuthenticateEvent({required this.context});
}
