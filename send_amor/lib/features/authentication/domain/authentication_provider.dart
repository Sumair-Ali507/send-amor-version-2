import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/data/network/api_services.dart';
import '../../../core/data/network/api_url.dart';
import '../data/app_user.dart';
import '../data/payload/register_user_payload.dart';



class AuthenticationProvider {
  Future<AppUser?> registerWithEmail({
    required BuildContext context,
    required RegisterUserPayload registerUserPayload,
  }) async {
    http.Response? response = await ApiServices().postApi(
        url: ApiUrl().registerURL,
        context: context,
        queryParameters: registerUserPayload.toJson());

    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);

      AppUser appUser = AppUser.fromJson(jsonResponse);
      return appUser;
    } else {
      return null;
    }
  }

  Future<AppUser?> loginWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    Map<String, String> queryParameters = {
      "email": email,
      "password": password
    };

    http.Response? response = await ApiServices().postApi(
      url: ApiUrl().loginURL,
      context: context,
      queryParameters: queryParameters,
    );

    if (response?.body != null) {
      Map<String, dynamic> jsonResponse = json.decode(response!.body);

      print("jsonResponse is: $jsonResponse");

      AppUser? appUser = AppUser.fromJson(jsonResponse);

      return appUser;
    }
    return null;
  }
}
