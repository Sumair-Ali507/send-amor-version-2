import 'package:money_transfer_app/features/recipient/data/payload/pending_connections_model.dart';

abstract class PendingConnectionsState {}

class PendingConnectionsInitial extends PendingConnectionsState {}

class PendingConnectionsLoading extends PendingConnectionsState {}

class PendingConnectionsLoaded extends PendingConnectionsState {
  final PendingConnectionsModel? pendingConnections;

  PendingConnectionsLoaded({this.pendingConnections});
}

class PendingConnectionsError extends PendingConnectionsState {
  final String message;

  PendingConnectionsError(this.message);
}