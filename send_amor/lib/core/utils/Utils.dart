import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/authentication/data/app_user.dart';
import '../constants/app_constant.dart';
import 'shared_preference_helper.dart';


class Utility {
  static String? textValidator(context, String? value) {
    value = value?.trim();
    if (value == null || value == '') {
      return ''; //I18n.of(context).requiredInput;
    } else if (value.length < 3)
      return ''; //I18n.of(context).tooShort;
    else
      return null;
  }

  static double calculatePercentage(
      double totalBillAmount, double discountAmount) {
    if (totalBillAmount == 0) {
      return 0.0;
    }
    double percentage = (discountAmount / totalBillAmount) * 100;
    return double.parse(percentage.toStringAsFixed(1));
  }

  static BoxShadow lightShadow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.2), // Shadow color with light opacity
      spreadRadius: 2, // How much the shadow spreads
      blurRadius: 5, // Softening the edges of the shadow
      offset: const Offset(0, 3), // Horizontal and vertical offset
    );
  }

  static String? codeValidator(context, String? value) {
    value = value?.trim();
    if (value == null || value == '') {
      return ''; //I18n.of(context).requiredInput;
    } else if (value.length < 6)
      return ''; //I18n.of(context).tooShort;
    else
      return null;
  }

  static String searchReady(String text) {
    text = text.trim();
    text = text.toLowerCase();
    text = text.replaceAll(RegExp(r'(?:_|[^\w\s])+'), '');
    return text;
  }

  static Future<bool> hasConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 10));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;}
  static String formatDate(String originalDateString) {
    // Parse the original date string to a DateTime object
    DateTime parsedDate = DateTime.parse(originalDateString);

    // Define a DateFormat for the desired output format
    DateFormat desiredFormat = DateFormat('dd/MM/yy');

    // Format the parsed DateTime object to the desired format
    String formattedDateString = desiredFormat.format(parsedDate);

    // Print the formatted date string
    return formattedDateString; // Output: 04/04/24
  }

  static String formatNumber(num unformatedNumber) {
    int number = unformatedNumber.toInt();
    String oldNumber = "$number";
    String newNumber = '';
    for (int i = oldNumber.length - 1; i >= 0; i--) {
      newNumber = oldNumber[i] + newNumber;
      if (i != oldNumber.length - 1 && i != 0) {
        int remaining = (oldNumber.length - i) % 3;
        if (remaining == 0) {
          newNumber = ' $newNumber';
        }
      }
    }
    return newNumber;
  }

  static String getTimeStamp() {
    DateTime now = DateTime.now().toUtc();
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(now);
    formattedDate += 'Z';
    return formattedDate;
  }

  static saveAppUser(AppUser appUser) {
    SharedPreferencesHelper.saveData<Map<String, dynamic>>(
        AppConstant.userData, appUser.toJson());
  }

  static String decodeString(String input) {
    try {
      // Convert the string to bytes and decode it
      return utf8.decode(input.runes.toList());
    } catch (e) {
      return input; // Return the input if decoding fails
    }
  }

  // Strip symbols for editing
  static String stripSymbols(String input) {
    // Remove the heart (❤️) symbol at the beginning if present
    if (input.startsWith('❤️')) {
      input = input.substring(2).trim();
    }
    // Remove the dollar sign ($) at the end if present
    if (input.endsWith('\$')) {
      input = input.substring(0, input.length - 1).trim();
    }
    return input;
  }

  static Future<AppUser?> getAppUser() async {
    Map<String, dynamic>? appUserMap =
        await SharedPreferencesHelper.getData<Map<String, dynamic>>(
            AppConstant.userData);
    if (appUserMap != null) {
      AppUser? appUser = AppUser.fromJson(appUserMap);
      return appUser;
    } else {
      return null;
    }
  }

  static String getReadableTime(String timeString) {
    final DateTime time = DateTime.parse(timeString);
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${time.day}-${time.month}-${time.year}';
    }
  }

  static String capitalize(String text) {
    String firstLetter = text[0];
    firstLetter = firstLetter.toUpperCase();
    String remaining = text.substring(1);
    remaining = remaining.toLowerCase();
    return firstLetter + remaining;
  }

  static String getLanguage(BuildContext context) {
    String language = Localizations.localeOf(context).languageCode;
    return language;
  }

  static String? getMapsKey() {
    String? key;
    if (Platform.isAndroid) {
      key = "YOUR GEO KEY";
    } else if (Platform.isIOS) {
      key = "AIzaSyBBllxTgOLRvmMYMAki4zTWnjT7rfpvQFo";
    }

    return key;
  }

  static Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }

    return null;
  }

  static bool isEmailValid(String email) {
    // Regular expression to match a valid email address
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
    );

    // Check if the email matches the regular expression
    return emailRegex.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    // Regular expressions to match valid password criteria
    final RegExp digitRegex = RegExp(r'[0-9]');
    final RegExp letterRegex = RegExp(r'[a-zA-Z]');
    final RegExp specialSymbolRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    // Check if the password meets the criteria
    return password.length >= 8 &&
        digitRegex.hasMatch(password) &&
        letterRegex.hasMatch(password) &&
        specialSymbolRegex.hasMatch(password);
  }

  static String getPowerBiHtml(String accessToken, String embedUrl) {
    String htmlContent = '''
              <!DOCTYPE html>
              <html>
              <head>
                  <script src="https://cdn.jsdelivr.net/npm/powerbi-client@2.7.0/dist/powerbi.min.js"></script>
                  <style>
                      #reportContainer {
                          width: 100%;
                          height: 100vh;
                      }
                  </style>
              </head>
              <body>
                  <div id="reportContainer"></div>
                  <script>
                      var embedUrl = $embedUrl; // Replace with your embed URL
                      var accessToken = "$accessToken"

                      var embedContainer = document.getElementById("reportContainer");
                      let models = window['powerbi-client'].models;
                      var report = powerbi.embed(embedContainer, {
                          type: "report",
                          accessToken: accessToken,
                          tokenType: models.TokenType.Embed,
                          embedUrl: embedUrl
                      });
                  </script>
              </body>
              </html>
            ''';

    return htmlContent;
  }
}
