// To parse this JSON data, do
//
//     final rePost = rePostFromJson(jsonString);

import 'dart:convert';

RePost rePostFromJson(String str) => RePost.fromJson(json.decode(str));

String rePostToJson(RePost data) => json.encode(data.toJson());

class RePost {
    RePost({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    String userId;
    String id;
    String title;
    String body;

    factory RePost.fromJson(Map<String, dynamic> json) => RePost(
        userId: json["userId"].toString(),
        id: json["id"].toString(),
        title: json["title"].toString(),
        body: json["body"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}