import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? "");
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  setUserType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userType", type);
    print("Stored roleId in SharedPreferences: $type");
  }

  Future<String> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userType") ?? "";
  }

  setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    print("Stored roleId in SharedPreferences token : $token");
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }
}
