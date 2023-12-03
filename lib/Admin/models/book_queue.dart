// To parse this JSON data, do
//
//     final bookQueue = bookQueueFromJson(jsonString);

import 'dart:convert';

List<BookQueue> bookQueueFromJson(String str) => List<BookQueue>.from(json.decode(str).map((x) => BookQueue.fromJson(x)));

String bookQueueToJson(List<BookQueue> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookQueue {
    String model;
    int pk;
    Fields fields;

    BookQueue({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BookQueue.fromJson(Map<String, dynamic> json) => BookQueue(
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
    String publisher;
    int pageCount;
    String genre;
    String isbn;
    String language;
    DateTime publishedDate;

    Fields({
        required this.user,
        required this.title,
        required this.author,
        required this.description,
        required this.publisher,
        required this.pageCount,
        required this.genre,
        required this.isbn,
        required this.language,
        required this.publishedDate,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        publisher: json["publisher"],
        pageCount: json["page_count"],
        genre: json["genre"],
        isbn: json["ISBN"],
        language: json["language"],
        publishedDate: DateTime.parse(json["published_date"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "author": author,
        "description": description,
        "publisher": publisher,
        "page_count": pageCount,
        "genre": genre,
        "ISBN": isbn,
        "language": language,
        "published_date": "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
    };
}
