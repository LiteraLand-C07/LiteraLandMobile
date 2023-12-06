// To parse this JSON data, do
//
//     final bookLists = bookListsFromJson(jsonString);

import 'dart:convert';

List<BookLists> bookListsFromJson(String str) => List<BookLists>.from(json.decode(str).map((x) => BookLists.fromJson(x)));

String bookListsToJson(List<BookLists> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookLists {
    String model;
    int pk;
    Fields fields;

    BookLists({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BookLists.fromJson(Map<String, dynamic> json) => BookLists(
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
    String name;
    String access;
    String description;
    String image;
    List<int> books;

    Fields({
        required this.name,
        required this.access,
        required this.description,
        required this.image,
        required this.books,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        access: json["access"],
        description: json["description"],
        image: json["image"],
        books: List<int>.from(json["books"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "access": access,
        "description": description,
        "image": image,
        "books": List<dynamic>.from(books.map((x) => x)),
    };
}
