import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BrowseBooks/models/book.dart'; // Update with correct path

class BookListTile extends StatelessWidget {
  final Book book;

  const BookListTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        book.title,
        style: const TextStyle(
          color: Colors.white, // Added 'const'
          fontSize: 18.0, // Increased font size
        ),
      ),
      subtitle: Text(
        'Author: ${book.author}',
        style: const TextStyle(
          color: Colors.white, // Added 'const'
          fontSize: 16.0, // Set font size
        ),
      ),
      onTap: () {
        // Implement the onTap action here, for example:
        // Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailsPage(book: book)));
      },
      // Other styling and behavior
    );
  }
}
