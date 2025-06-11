import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_transfer_app/features/recipient/domain/recipients_repository.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/received_pending_connections_event.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/received_pending_connections_state.dart';

class ReceivedPendingConnectionsBloc extends Bloc<
    ReceivedPendingConnectionsEvent, ReceivedPendingConnectionsState> {
  final RecipientsRepository _recipientsRepository;
  int acceptedPendingPage = 0;
  final int pageSize = 10;

  ReceivedPendingConnectionsBloc(
      {required RecipientsRepository recipientsRepository})
      : _recipientsRepository = recipientsRepository,
        super(ReceivedPendingConnectionsInitial()) {
    on<FetchReceivedPendingConnections>(_onFetchReceivedPendingConnections);
  }

  Future<void> _onFetchReceivedPendingConnections(
      FetchReceivedPendingConnections event,
      Emitter<ReceivedPendingConnectionsState> emit) async {
    emit(ReceivedPendingConnectionsLoading());
    try {
      final receivedPendingConnections =
          await _recipientsRepository.receivedPendingConnectionsList(
        appUser: event.appUser,
        context: event.context,
        page: acceptedPendingPage,
        size: pageSize,
      );
      emit(ReceivedPendingConnectionsLoaded(
          receivedPendingConnections: receivedPendingConnections));
    } catch (e) {
      emit(ReceivedPendingConnectionsError(e.toString()));
    }
  }
}
