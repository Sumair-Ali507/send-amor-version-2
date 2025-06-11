import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import '../../../core/data/network/api_services.dart';
import '../../../core/data/network/api_url.dart';

class ProfileProvider {
  Future<AppUser?> setUserName(
      {required BuildContext context,
      required AppUser appUser,
      required String newUsername}) async {
    Map<String, String> queryParameters = {
      "email": appUser.appUserData?.email ?? '',
      "newUsername": newUsername
    };

    http.Response? response = await ApiServices().putApi(
        url: ApiUrl().setUserNameURL,
        context: context,
        queryParameters: queryParameters,
        requireAuthorization: true,
        user: appUser);

    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);
      AppUser? responseUserData = AppUser.fromJson(jsonResponse);

      if (responseUserData.success == true) {
        appUser = appUser.copyWith(appUserData: responseUserData.appUserData);
        return appUser;
      } else {
        return responseUserData;
      }
    } else {
      return null;
    }
  }

  Future<AppUser?> fetchUserDetails({
    required BuildContext context,
    required AppUser appUser,
  }) async {
    Map<String, String> queryParameters = {
      "email": appUser.appUserData?.email ?? '',
    };

    http.Response? response = await ApiServices().postApi(
        url: ApiUrl().fetchUserDetailsURL,
        context: context,
        queryParameters: queryParameters,
        requireAuthorization: true,
        user: appUser);

    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);
      AppUser? responseUserData = AppUser.fromJson(jsonResponse);
      appUser = appUser.copyWith(appUserData: responseUserData.appUserData);

      return appUser;
    } else {
      return null;
    }
  }
}
