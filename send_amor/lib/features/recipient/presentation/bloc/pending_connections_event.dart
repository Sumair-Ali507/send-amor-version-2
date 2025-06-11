import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';

abstract class PendingConnectionsEvent {}

class FetchPendingConnections extends PendingConnectionsEvent {
  final AppUser appUser;
  final BuildContext context;
  final int page;
  final int size;

  FetchPendingConnections({
    required this.appUser,
    required this.context,
    this.page = 0,
    this.size = 10,
  });
}