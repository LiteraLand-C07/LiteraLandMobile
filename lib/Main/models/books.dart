// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String author;
    String description;
    String publisher;
    int pageCount;
    String genre;
    String isbn;
    Language language;
    DateTime publishedDate;

    Fields({
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
        title: json["title"],
        author: json["author"],
        description: json["description"],
        publisher: json["publisher"],
        pageCount: json["page_count"],
        genre: json["genre"],
        isbn: json["ISBN"],
        language: languageValues.map[json["language"]]!,
        publishedDate: DateTime.parse(json["published_date"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "description": description,
        "publisher": publisher,
        "page_count": pageCount,
        "genre": genre,
        "ISBN": isbn,
        "language": languageValues.reverse[language],
        "published_date": "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
    };
}

enum Language {
    ENGLISH
}

final languageValues = EnumValues({
    "English": Language.ENGLISH
});

enum Model {
    SHARED_MODELS_BOOK
}

final modelValues = EnumValues({
    "shared_models.book": Model.SHARED_MODELS_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
