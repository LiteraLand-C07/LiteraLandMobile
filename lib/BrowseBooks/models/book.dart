class Book {
  final String title;
  final String author;

  Book({
    required this.title,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['fields']['title'] as String,
      author: json['fields']['author'] as String,
    );
  }
}
