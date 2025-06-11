import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_transfer_app/features/recipient/domain/recipients_repository.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/accepted_connections_event.dart';
import 'package:money_transfer_app/features/recipient/presentation/bloc/accepted_connections_state.dart';

class AcceptedConnectionsBloc
    extends Bloc<AcceptedConnectionsEvent, AcceptedConnectionsState> {
  final RecipientsRepository _recipientsRepository;
  int acceptedPage = 0;
  final int pageSize = 10;

  AcceptedConnectionsBloc({required RecipientsRepository recipientsRepository})
      : _recipientsRepository = recipientsRepository,
        super(AcceptedConnectionsInitial()) {
    on<FetchAcceptedConnections>(_onFetchAcceptedConnections);
  }

  Future<void> _onFetchAcceptedConnections(FetchAcceptedConnections event,
      Emitter<AcceptedConnectionsState> emit) async {
    emit(AcceptedConnectionsLoading());
    try {
      final acceptedConnections =
          await _recipientsRepository.acceptedConnectionsList(
        appUser: event.appUser,
        context: event.context,
        page: acceptedPage,
        size: pageSize,
      );
      acceptedPage++;
      emit(AcceptedConnectionsLoaded(acceptedConnections: acceptedConnections));
    } catch (e) {
      emit(AcceptedConnectionsError(e.toString()));
    }
  }
}
