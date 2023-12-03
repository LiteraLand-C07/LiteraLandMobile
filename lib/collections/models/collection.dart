// To parse this JSON data, do
//
//     final bookCollection = bookCollectionFromJson(jsonString);

import 'dart:convert';

List<BookCollection> bookCollectionFromJson(String str) =>
    List<BookCollection>.from(
        json.decode(str).map((x) => BookCollection.fromJson(x)));

String bookCollectionToJson(List<BookCollection> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookCollection {
  int book;
  String title;
  String author;
  int pageCount;
  String genre;
  String isbn;
  int pk;
  int rating;
  int currentPage;
  String statusBaca;
  String statusBacaDisplay;

  BookCollection({
    required this.book,
    required this.title,
    required this.author,
    required this.pageCount,
    required this.genre,
    required this.isbn,
    required this.pk,
    required this.rating,
    required this.currentPage,
    required this.statusBaca,
    required this.statusBacaDisplay,
  });

  factory BookCollection.fromJson(Map<String, dynamic> json) => BookCollection(
        book: json["book"],
        title: json["title"],
        author: json["author"],
        pageCount: json["page_count"],
        genre: json["genre"],
        isbn: json["ISBN"],
        pk: json["pk"],
        rating: json["rating"],
        currentPage: json["current_page"],
        statusBaca: json["status_baca"],
        statusBacaDisplay: json["status_baca_display"],
      );

  Map<String, dynamic> toJson() => {
        "book": book,
        "title": title,
        "author": author,
        "page_count": pageCount,
        "genre": genre,
        "ISBN": isbn,
        "pk": pk,
        "rating": rating,
        "current_page": currentPage,
        "status_baca": statusBaca,
        "status_baca_display": statusBacaDisplay,
      };
}
