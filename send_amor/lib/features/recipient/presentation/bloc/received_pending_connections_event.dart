import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';

abstract class ReceivedPendingConnectionsEvent {}

class FetchReceivedPendingConnections extends ReceivedPendingConnectionsEvent {
  final AppUser appUser;
  final BuildContext context;
  final int page;
  final int size;

  FetchReceivedPendingConnections({
    required this.appUser,
    required this.context,
    this.page = 0,
    this.size = 10,
  });
}
