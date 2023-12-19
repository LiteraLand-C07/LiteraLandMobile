// To parse this JSON data, do
//
//     final requestBook = requestBookFromJson(jsonString);

import 'dart:convert';

List<BookRequest> requestBookFromJson(String str) => List<BookRequest>.from(json.decode(str).map((x) => BookRequest.fromJson(x)));

String requestBookToJson(List<BookRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookRequest {
    String model;
    int pk;
    Fields fields;

    BookRequest({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BookRequest.fromJson(Map<String, dynamic> json) => BookRequest(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String title;
    String author;
    String description;
    DateTime createdAt;

    Fields({
        required this.user,
        required this.title,
        required this.author,
        required this.description,
        required this.createdAt,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "author": author,
        "description": description,
        "created_at": createdAt.toIso8601String(),
    };
}
