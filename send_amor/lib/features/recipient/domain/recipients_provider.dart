import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:money_transfer_app/core/data/network/api_services.dart';
import 'package:money_transfer_app/core/data/network/api_url.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/recipient/data/payload/accepted_connections_model.dart';
import 'package:money_transfer_app/features/recipient/data/payload/pending_connections_model.dart';
import 'package:money_transfer_app/features/recipient/data/payload/received_pending_connections_model.dart';
import 'package:money_transfer_app/features/recipient/data/payload/search_user.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/features/recipient/data/payload/send_connections_model.dart';

class RecipientsProvider {
  Future<SearchUsers?> searchRecipientsList({
    required AppUser? appUser,
    required String query,
    required BuildContext context,
  }) async {
    Map<String, String> queryParameters = {
      "query": query,
    };

    http.Response? response = await ApiServices().postApi(
      url: ApiUrl().searchURL,
      context: context,
      queryParameters: queryParameters,
      requireAuthorization: true,
      user: appUser,
    );
    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);
      SearchUsers searchUser = SearchUsers.fromJson(jsonResponse);
      return searchUser;
    }
    return null;
  }

  Future<SendConnectionsModel?> sendConnectionsList({
    required AppUser? appUser,
    required String receiverId,
    required BuildContext context,
  }) async {
    Map<String, String> queryParameters = {
      "senderId": appUser?.appUserData?.id?.toString() ?? '',
      "receiverId": receiverId,
    };

    http.Response? response = await ApiServices().postApi(
      url: ApiUrl().sendConnectionURL,
      context: context,
      queryParameters: queryParameters,
      requireAuthorization: true,
      user: appUser,
    );
    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);
      SendConnectionsModel sendConnectionsModel =
          SendConnectionsModel.fromJson(jsonResponse);
      return sendConnectionsModel;
    }
    return null;
  }

  Future<PendingConnectionsModel?> pendingConnectionsList({
    required AppUser? appUser,
    required int page,
    required int size,
    required BuildContext context,
  }) async {
    Map<String, String> queryParameters = {
      "userId": appUser?.appUserData?.id?.toString() ?? '',
      "page": page.toString(),
      "size": size.toString(),
      "sortBy": 'createdAt',
    };

    http.Response? response = await ApiServices().postApi(
      url: ApiUrl().pendingConnectionURL,
      context: context,
      queryParameters: queryParameters,
      requireAuthorization: true,
      user: appUser,
    );
    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);
      PendingConnectionsModel pendingConnectionsModel =
          PendingConnectionsModel.fromJson(jsonResponse);
      return pendingConnectionsModel;
    }
    return null;
  }

  Future<AcceptedConnectionsModel?> acceptedConnectionsList({
    required AppUser? appUser,
    required int page,
    required int size,
    required BuildContext context,
  }) async {

    Map<String, String> queryParameters = {
      "userId": appUser?.appUserData?.id?.toString() ?? '',
      "page": page.toString(),
      "size": size.toString(),
      "sortBy": 'createdAt',

    };

    http.Response? response = await ApiServices().postApi(
      url: ApiUrl().acceptedConnectionURL,
      context: context,
      queryParameters: queryParameters,
      requireAuthorization: true,
      user: appUser,
    );
    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);
      AcceptedConnectionsModel acceptedConnectionsModel =
          AcceptedConnectionsModel.fromJson(jsonResponse);
      return acceptedConnectionsModel;
    }
    return null;
  }

  Future<ReceivedPendingConnectionListModel?> receivedPendingConnectionsList({
    required AppUser? appUser,
    required int page,
    required int size,
    required BuildContext context,
  }) async {
    Map<String, String> queryParameters = {
      "userId": appUser?.appUserData?.id?.toString() ?? '',
      "page": page.toString(),
      "size": size.toString(),
      "sortBy": 'createdAt',
    };

    http.Response? response = await ApiServices().postApi(
      url: ApiUrl().receivedConnectionURL,
      context: context,
      queryParameters: queryParameters,
      requireAuthorization: true,
      user: appUser,
    );
    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);
      ReceivedPendingConnectionListModel receivedPendingConnectionsModel =
          ReceivedPendingConnectionListModel.fromJson(jsonResponse);
      return receivedPendingConnectionsModel;
    }
    return null;
  }

  Future<void> updateConnectionStatus({
    required AppUser? appUser,
    required int connectionId,
    required String status,
    required BuildContext context,
  }) async {
    Map<String, dynamic> queryParameters = {
      "userId": appUser?.appUserData?.id?.toString() ?? '',
      "connectionId": connectionId,
      "status": status
    };

    http.Response? response = await ApiServices().putApi(
      url: ApiUrl().updateConnectionStatusURL,
      context: context,
      queryParameters: queryParameters,
      requireAuthorization: true,
      user: appUser,
    );
    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);
    }
    return null;
  }
}
