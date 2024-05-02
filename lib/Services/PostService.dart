import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp_six/Models/Post.dart';
import 'package:tp_six/Services/Dio.dart';

class PostService {

  Dio api = configureOptions();

  Future<List<Post>> getPosts () async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    if (token != "") api.options.headers["AUTHORIZATION"] = "Bearer $token";

    final response = await api.get("posts");
    return (response.data as List).map((e) => Post.fromJson(e)).toList();
  }

  Future<Post> getPost (String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    if (token != "") api.options.headers["AUTHORIZATION"] = "Bearer $token";

    final response = await api.get("posts/$id");
    return Post.fromJson(response.data);
  }

  Future<Post> createPost (Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    if (token != "") api.options.headers["AUTHORIZATION"] = "Bearer $token";

    final response = await api.post("posts", data : data);
    return Post.fromJson(response.data);
  }

  Future<Post> updatePost (Map<String, dynamic> data, String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    if (token != "") api.options.headers["AUTHORIZATION"] = "Bearer $token";

    final response = await api.patch("posts/$id", data : data);
    return Post.fromJson(response.data);
  }

  Future<Response> deletePost (String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    if (token != "") api.options.headers["AUTHORIZATION"] = "Bearer $token";

    final response = await api.delete("posts/$id");
    return response;
  }

}