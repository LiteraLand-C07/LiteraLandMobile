import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BrowseBooks/models/book.dart'; // Update with correct path

class BookListTile extends StatelessWidget {
  final Book book;

  BookListTile({required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text('Author: ${book.author}\nGenre: ${book.genres.join(', ')}'),
      // Other styling and behavior
    );
  }
}
