import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/features/authentication/presentation/pages/login_page.dart';
import '../../../features/authentication/data/app_user.dart';
import '../../../features/authentication/domain/authentication_repository.dart';
import '../../../features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';

class ApiServices {
  Future<http.Response?> postApi({
    required String url,
    required BuildContext context,
    var queryParameters,
    Map<String, String>? customHeader,
    AppUser? user,
    bool requireHeader = true,
    bool requireAuthorization = false,
  }) async {
    try {
      Map<String, String>? header = {};

      // Handle custom headers or authorization if required
      if (customHeader != null) {
        header = customHeader;
      } else if (requireAuthorization) {
        // Uncomment and set up authorization if required
        header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user?.appUserData?.token}"
        };
      } else if (requireHeader) {
        header = {
          "Content-Type": "application/json",
        };
      }



      debugPrint('---API URL----> $url');
      debugPrint('---Header----\n $header');
      debugPrint('---QueryParameters----\n $queryParameters');

      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(queryParameters),
      );

      // Log the status code and response body for debugging
      print('response status code: ${response.statusCode}');
      print('response body: ${response.body}');

      // Check for successful response
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        debugPrint('---Response----\n ${jsonResponse.toString()}');
        return response;
      } else if (response.statusCode == 403) {
        print('Error: ${response.statusCode}');
        Fluttertoast.showToast(msg: AppTexts.invalidToken);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => BlocProvider(
                    create: (context) => AuthenticationBloc(
                        authenticationRepository: AuthenticationRepository()),
                    child: const LoginPage(),
                  )),
          (Route<dynamic> route) =>
              false, // This line removes all routes from the stack
        );
        return null;
      }
    } catch (e) {
      print('Error in API call: $e');
      return null;
    }
  }



  Future<http.Response?> putApi({
    required String url,
    Map<String, dynamic>? queryParameters,
    bool requireHeader = true,
    required BuildContext context,
    bool requireAuthorization = false,
    AppUser? user,
    Map<String, String>? customHeader,
  }) async {
    try {
      Map<String, String>? header = {};

      if (customHeader != null) {
        header = customHeader;
      } else if (requireAuthorization) {
        header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user?.appUserData?.token}"
        };
      } else if (requireHeader) {
        header = {
          "Content-Type": "application/json",
        };
      }

      debugPrint('---API URL----> $url');
      debugPrint('---Header----\n $header');
      debugPrint('---QueryParameters----\n $queryParameters');

      http.Response response = await http.put(Uri.parse(url),
          headers: header, body: json.encode(queryParameters));

      Map<String, dynamic> jsonResponse = json.decode(response.body);
      debugPrint('---Response----\n ${jsonResponse.toString()}');

      if (jsonResponse['message'] == AppTexts.appName) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => BlocProvider(
                    create: (context) => AuthenticationBloc(
                        authenticationRepository: AuthenticationRepository()),
                    child: const LoginPage(),
                  )),
          (Route<dynamic> route) =>
              false, // This line removes all routes from the stack
        );
        return null;
      } else {
        return response;
      }
    } catch (e) {
      return null;
    }
  }
}
