part of 'send_connections_bloc.dart';

abstract class SendConnectionState extends Equatable {
  const SendConnectionState();

  @override
  List<Object> get props => [];
}

class SendConnectionInitial extends SendConnectionState {}

class SendConnectionLoading extends SendConnectionState {}

class SendConnectionSuccess extends SendConnectionState {
  final SendConnectionsModel sendConnectionsModel;

  const SendConnectionSuccess({required this.sendConnectionsModel});

  @override
  List<Object> get props => [sendConnectionsModel];
}

class SendConnectionFailure extends SendConnectionState {
  final String error;

  const SendConnectionFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateConnectionStatusInProgress extends SendConnectionState {}

class UpdateConnectionStatusSuccess extends SendConnectionState {
  const UpdateConnectionStatusSuccess();
}

class UpdateConnectionStatusFailure extends SendConnectionState {
  final String error;

  const UpdateConnectionStatusFailure({required this.error});

  @override
  List<Object> get props => [error];
}
