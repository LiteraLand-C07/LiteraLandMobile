import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BrowseBooks/models/book.dart'; // Update with correct path
import 'package:litera_land_mobile/collections/models/detail_book.dart';
import 'package:litera_land_mobile/collections/screens/detail_book.dart';


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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(bookId: book.id), // Use your actual DetailBookPage here
          ),
        );
      },
      // Other styling and behavior
    );
  }
}
