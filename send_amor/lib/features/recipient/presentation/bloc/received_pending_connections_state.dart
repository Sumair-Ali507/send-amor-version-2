import 'package:money_transfer_app/features/recipient/data/payload/received_pending_connections_model.dart';

abstract class ReceivedPendingConnectionsState {}

class ReceivedPendingConnectionsInitial
    extends ReceivedPendingConnectionsState {}

class ReceivedPendingConnectionsLoading
    extends ReceivedPendingConnectionsState {}

class ReceivedPendingConnectionsLoaded extends ReceivedPendingConnectionsState {
  final ReceivedPendingConnectionListModel? receivedPendingConnections;

  ReceivedPendingConnectionsLoaded({this.receivedPendingConnections});
}

class ReceivedPendingConnectionsError extends ReceivedPendingConnectionsState {
  final String message;

  ReceivedPendingConnectionsError(this.message);
}
