import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/profile/domain/profile_provider.dart';

import '../../authentication/data/app_user.dart';

class ProfileRepository {
  final _provider = ProfileProvider();

  Future<AppUser?> setUserName(
      {required BuildContext context,
      required AppUser appUser,
      required String newUsername}) async {
    return _provider.setUserName(
        context: context, appUser: appUser, newUsername: newUsername);
  }

  Future<AppUser?> fetchUserDetails({
    required BuildContext context,
    required AppUser appUser,
  }) async {
    return _provider.fetchUserDetails(context: context, appUser: appUser);
  }
}
