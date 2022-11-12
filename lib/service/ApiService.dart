import 'dart:convert';

import 'package:http/http.dart';
import 'package:pdpar2/model/Post.dart';
import 'package:pdpar2/model/RePost.dart';

class ApiService {
  static Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  static String GET_API = "/posts";
  static String BASE = "jsonplaceholder.typicode.com";

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<List<Post>?> GET(String api, Map<String, String> params) async {
    var q = Uri.https(BASE, GET_API, params);
    var response = await get(q);
    if (response.statusCode == 200) {
      return postFromJson(response.body);
    }
    return null;
  }

  static Future<bool?> DELETE(String api, Map<String, String> params) async {
    var q = Uri.https(BASE, api, params);
    var response = await delete(q);
    if (response.statusCode == 200) {
      if (response.body == "{}") {
        return true;
      }
    }
    return null;
  }

  static Future<RePost?> UPDATE(String api, Map<String, String> params) async {
    var q = Uri.https(BASE, api, params);
    var response = await delete(q);
    if (response.statusCode == 200) {
      print(response.body);
      return rePostFromJson(response.body);
    }
    return null;
  }

//  HTTP params

  static Map<String, String> paramsPost(Post post) {
    Map<String, String> params = {};
    params.addAll({
      'userId': post.userId.toString(),
      'id': post.id.toString(),
      'title': post.title,
      'body': post.body,
    });
    return params;
  }

// static RePost parsePost(String json){
//   dynamic j = jsonDecode(json);
//   var rs = RePost.fromJson(j);
//   return rs;
// }
}
