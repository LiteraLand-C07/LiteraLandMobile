class Book {
  final int id;
  final String title;
  final String author;

  Book({
    required this.id,
    required this.title,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['pk'] as int,
      title: json['fields']['title'] as String,
      author: json['fields']['author'] as String,
    );
  }
}
