import '../../features/authentication/data/app_user.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  AppUser? appUser;

  UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  static void setUser(AppUser user) {
    _instance.appUser = user;
  }

  static AppUser? getUser() {
    return _instance.appUser;
  }
}
