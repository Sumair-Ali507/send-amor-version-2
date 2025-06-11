import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/recipient/data/payload/send_connections_model.dart';
import 'package:money_transfer_app/features/recipient/domain/recipients_repository.dart';
part 'send_connections_event.dart';
part 'send_connections_state.dart';

class SendConnectionBloc
    extends Bloc<SendConnectionEvent, SendConnectionState> {
  final RecipientsRepository _recipientsRepository;

  SendConnectionBloc({required RecipientsRepository recipientsRepository})
      : _recipientsRepository = recipientsRepository,
        super(SendConnectionInitial()) {
    on<SendConnectionRequested>(_onSendConnectionRequested);
    on<UpdateConnectionStatusEvent>(_onUpdateConnectionStatus);
  }

  Future<void> _onSendConnectionRequested(
      SendConnectionRequested event, Emitter<SendConnectionState> emit) async {
    emit(SendConnectionLoading());
    try {
      final sendConnectionsModel =
          await _recipientsRepository.sendConnectionsList(
        context: event.context,
        appUser: event.appUser,
        receiverId: event.receiverId,
      );
      if (sendConnectionsModel != null) {
        emit(SendConnectionSuccess(sendConnectionsModel: sendConnectionsModel));
      } else {
        emit(const SendConnectionFailure(error: 'Failed to send connection'));
      }
    } catch (e) {
      emit(SendConnectionFailure(error: e.toString()));
    }
  }

  Future<void> _onUpdateConnectionStatus(UpdateConnectionStatusEvent event,
      Emitter<SendConnectionState> emit) async {
    emit(UpdateConnectionStatusInProgress());
    try {
      await _recipientsRepository.updateConnectionStatus(
          context: event.context,
          appUser: event.appUser,
          connectionId: event.connectionId,
          status: event.status);
      emit(const UpdateConnectionStatusSuccess());
      // if (sendConnectionsModel != null) {
      //   emit(const UpdateConnectionStatusSuccess());
      // } else {
      //   emit(const UpdateConnectionStatusFailure(
      //       error: 'Failed to send connection'));
      // }
    } catch (e) {
      emit(UpdateConnectionStatusFailure(error: e.toString()));
    }
  }
}
