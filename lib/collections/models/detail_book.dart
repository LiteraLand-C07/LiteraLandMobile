// To parse this JSON data, do
//
//     final detailBook = detailBookFromJson(jsonString);

import 'dart:convert';

List<DetailBook> detailBookFromJson(String str) =>
    List<DetailBook>.from(json.decode(str).map((x) => DetailBook.fromJson(x)));

String detailBookToJson(List<DetailBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailBook {
  double rating;
  String title;
  String author;
  String publisher;
  int pageCount;
  String genre;
  String isbn;
  String language;
  String publishedDate;
  String description;

  DetailBook({
    required this.rating,
    required this.title,
    required this.author,
    required this.publisher,
    required this.pageCount,
    required this.genre,
    required this.isbn,
    required this.language,
    required this.publishedDate,
    required this.description,
  });

  factory DetailBook.fromJson(Map<String, dynamic> json) => DetailBook(
        rating: json["rating"]?.toDouble() ?? 0.0,
        title: json["title"],
        author: json["author"],
        publisher: json["publisher"],
        pageCount: json["page_count"],
        genre: json["genre"],
        isbn: json["ISBN"],
        language: json["language"],
        publishedDate: json["published_date"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "title": title,
        "author": author,
        "publisher": publisher,
        "page_count": pageCount,
        "genre": genre,
        "ISBN": isbn,
        "language": language,
        "published_date": publishedDate,
        "description": description,
      };
}
