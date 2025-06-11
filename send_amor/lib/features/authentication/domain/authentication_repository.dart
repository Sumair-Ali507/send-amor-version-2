import 'package:flutter/material.dart';

import '../data/app_user.dart';
import '../data/payload/register_user_payload.dart';
import 'authentication_provider.dart';

class AuthenticationRepository {
  final _provider = AuthenticationProvider();

  Future<AppUser?> registerWithEmail({
    required BuildContext context,
    required RegisterUserPayload registerUserPayload,
  }) async {
    return _provider.registerWithEmail(
        context: context, registerUserPayload: registerUserPayload);
  }

  Future<AppUser?> loginWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    return _provider.loginWithEmail(
        context: context, email: email, password: password);
  }
}
