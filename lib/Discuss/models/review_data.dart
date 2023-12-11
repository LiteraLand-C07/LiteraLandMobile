// To parse this JSON data, do
//
//     final reviewBook = reviewBookFromJson(jsonString);

import 'dart:convert';

List<ReviewBook> reviewBookFromJson(String str) =>
    List<ReviewBook>.from(json.decode(str).map((x) => ReviewBook.fromJson(x)));

String reviewBookToJson(List<ReviewBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewBook {
  String model;
  int pk;
  Fields fields;

  ReviewBook({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory ReviewBook.fromJson(Map<String, dynamic> json) => ReviewBook(
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
  int book;
  String? review;
  String reviewerName;
  DateTime date;
  int starRating;

  Fields({
    required this.user,
    required this.book,
    required this.review,
    required this.reviewerName,
    required this.date,
    required this.starRating,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        review: json["review"],
        reviewerName: json["reviewer_name"],
        date: DateTime.parse(json["date"]),
        starRating: json["star_rating"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "review": review,
        "reviewer_name": reviewerName,
        "date": date.toIso8601String(),
        "star_rating": starRating,
      };
}
