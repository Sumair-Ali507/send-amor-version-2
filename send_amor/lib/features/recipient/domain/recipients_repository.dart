import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/recipient/data/payload/accepted_connections_model.dart';
import 'package:money_transfer_app/features/recipient/data/payload/pending_connections_model.dart';
import 'package:money_transfer_app/features/recipient/data/payload/received_pending_connections_model.dart';
import 'package:money_transfer_app/features/recipient/data/payload/search_user.dart';
import 'package:money_transfer_app/features/recipient/data/payload/send_connections_model.dart';
import 'package:money_transfer_app/features/recipient/domain/recipients_provider.dart';

class RecipientsRepository {
  final _provider = RecipientsProvider();
  Future<SearchUsers?> searchRecipientsList({
    required BuildContext context,
    required String query,
    AppUser? appUser,
  }) async {
    return _provider.searchRecipientsList(
        context: context, query: query, appUser: appUser);
  }

  Future<SendConnectionsModel?> sendConnectionsList({
    required AppUser? appUser,
    required String receiverId,
    required BuildContext context,
  }) async {
    return _provider.sendConnectionsList(
        context: context, appUser: appUser, receiverId: receiverId);
  }

  Future<PendingConnectionsModel?> pendingConnectionsList({
    required BuildContext context,
    required int page,
    required int size,
    required AppUser? appUser,
  }) async {
    return _provider.pendingConnectionsList(
        context: context, appUser: appUser, page: page, size: size);
  }

  Future<AcceptedConnectionsModel?> acceptedConnectionsList({
    required BuildContext context,
    required int page,
    required int size,
    required AppUser? appUser,
  }) async {
    return _provider.acceptedConnectionsList(
        context: context, appUser: appUser, page: page, size: size);
  }

  Future<ReceivedPendingConnectionListModel?> receivedPendingConnectionsList({
    required BuildContext context,
    required int page,
    required int size,
    required AppUser? appUser,
  }) async {
    return _provider.receivedPendingConnectionsList(
        context: context, appUser: appUser, page: page, size: size);
  }

  Future<void> updateConnectionStatus({
    required AppUser? appUser,
    required int connectionId,
    required String status,
    required BuildContext context,
  }) {
    return _provider.updateConnectionStatus(
        appUser: appUser,
        connectionId: connectionId,
        status: status,
        context: context);
  }
}
