import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp_six/Models/AuthenticatedUser.dart';
import 'package:tp_six/Services/Dio.dart';

class UserService {

  Dio api = configureOptions();

  Future<AuthenticatedUser> login (Map<String, dynamic> data) async {
    final response = await api.post("authentication", data : data);
    return AuthenticatedUser.fromJson(response.data);
  }

  Future<User> register (Map<String, dynamic> data) async {
    final response = await api.post("users", data : data);
    return User.fromJson(response.data);
  }

  Future<User> getUserbyId (String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    if (token != "") api.options.headers["AUTHORIZATION"] = "Bearer $token";

    final response = await api.post("users/$id");
    return User.fromJson(response.data);
  }
  Future<User> getUserbyAccessToken (String token) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    if (token != "") api.options.headers["AUTHORIZATION"] = "Bearer $token";

    final response = await api.post("users/$token");
    return User.fromJson(response.data);
  }


}