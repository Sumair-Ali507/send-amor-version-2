import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Save any data to SharedPreferences
  static Future<void> saveData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      String jsonString = jsonEncode(value);
      await prefs.setString(key, jsonString); // Save map as JSON string
    } else {
      throw Exception("Unsupported data type");
    }
  }

  // Retrieve data from SharedPreferences
  static Future<T?> getData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else if (T == Map<String, dynamic>) {
      String? jsonString = prefs.getString(key);
      if (jsonString != null) {
        return jsonDecode(jsonString) as T; // Convert JSON string back to map
      }
    }
    return null; // Return null if key does not exist or unsupported type
  }

  // Remove data from SharedPreferences
  static Future<void> removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Clear all data from SharedPreferences
  static Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
