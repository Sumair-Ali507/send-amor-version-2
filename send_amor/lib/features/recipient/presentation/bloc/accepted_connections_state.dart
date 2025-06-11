import 'package:money_transfer_app/features/recipient/data/payload/accepted_connections_model.dart';

abstract class AcceptedConnectionsState {}

class AcceptedConnectionsInitial extends AcceptedConnectionsState {}

class AcceptedConnectionsLoading extends AcceptedConnectionsState {}

class AcceptedConnectionsLoaded extends AcceptedConnectionsState {
  final AcceptedConnectionsModel? acceptedConnections;


  AcceptedConnectionsLoaded({
    this.acceptedConnections,
  });
}

class AcceptedConnectionsError extends AcceptedConnectionsState {
  final String message;

  AcceptedConnectionsError(this.message);
}
