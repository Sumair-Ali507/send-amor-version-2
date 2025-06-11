part of 'send_connections_bloc.dart';

abstract class SendConnectionEvent extends Equatable {
  const SendConnectionEvent();

  @override
  List<Object> get props => [];
}

class SendConnectionRequested extends SendConnectionEvent {
  final AppUser appUser;
  final BuildContext context;
  final String receiverId;
  const SendConnectionRequested(
      {required this.appUser, required this.context, required this.receiverId});

  @override
  List<Object> get props => [appUser, context];
}

class UpdateConnectionStatusEvent extends SendConnectionEvent {
  final AppUser appUser;
  final BuildContext context;
  final int connectionId;
  final String status;

  const UpdateConnectionStatusEvent(
      {required this.appUser,
      required this.context,
      required this.connectionId,
      required this.status});
}
