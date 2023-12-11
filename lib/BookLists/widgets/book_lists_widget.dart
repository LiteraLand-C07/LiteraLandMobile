import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BookLists/models/book_lists_models.dart';

class BookListsWidget extends StatelessWidget {
  final BookLists bookList;

  const BookListsWidget({super.key, required this.bookList});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(bookList.fields.name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(bookList.fields.description, style: const TextStyle(color: Colors.white)),
    );
  }
}