// To parse this JSON data, do
//
//     final reviewBook = reviewBookFromJson(jsonString);

import 'dart:convert';

ReviewBook reviewBookFromJson(String str) => ReviewBook.fromJson(json.decode(str));

String reviewBookToJson(ReviewBook data) => json.encode(data.toJson());

class ReviewBook {
    String greeting;
    List<String> instructions;

    ReviewBook({
        required this.greeting,
        required this.instructions,
    });

    factory ReviewBook.fromJson(Map<String, dynamic> json) => ReviewBook(
        greeting: json["greeting"],
        instructions: List<String>.from(json["instructions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "greeting": greeting,
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
    };
}
