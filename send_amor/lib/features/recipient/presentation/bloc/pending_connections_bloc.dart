import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_transfer_app/features/recipient/domain/recipients_repository.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/pending_connections_event.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/pending_connections_state.dart';

class PendingConnectionsBloc
    extends Bloc<PendingConnectionsEvent, PendingConnectionsState> {
  final RecipientsRepository _recipientsRepository;
  int pendingPage = 0;
  final int pageSize = 10;

  PendingConnectionsBloc({required RecipientsRepository recipientsRepository})
      : _recipientsRepository = recipientsRepository,
        super(PendingConnectionsInitial()) {
    on<FetchPendingConnections>(_onFetchPendingConnections);
  }

  Future<void> _onFetchPendingConnections(FetchPendingConnections event,
      Emitter<PendingConnectionsState> emit) async {
    emit(PendingConnectionsLoading());
    try {
      final pendingConnections =
          await _recipientsRepository.pendingConnectionsList(
        appUser: event.appUser,
        context: event.context,
        page: pendingPage,
        size: pageSize,
      );
      pendingPage++;
      emit(PendingConnectionsLoaded(pendingConnections: pendingConnections));
    } catch (e) {
      emit(PendingConnectionsError(e.toString()));
    }
  }
}
