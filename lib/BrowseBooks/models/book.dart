class Book {
  final String title;
  final String author;
  final List<String> genres;

  Book({required this.title, required this.author, required this.genres});

  // Factory constructor to create a Book from a map (e.g., JSON).
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String,
      author: json['authors'].join(', '),
      genres: List<String>.from(json['categories']),
    );
  }
}
