import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BookLists/models/book_lists_models.dart';

class DetailPage extends StatelessWidget {
  final BookLists bookList;

  const DetailPage({Key? key, required this.bookList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      appBar: AppBar(
        title: const Text('Book Details'),
        backgroundColor:
            const Color.fromARGB(255, 15, 15, 15), // Dark themed AppBar color
        foregroundColor: Colors.white, // Text color for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${bookList.fields.name}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // Set the RGB color
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${bookList.fields.description}',
              style: TextStyle(fontSize: 16, color: Colors.white), // Adjust text color as needed
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Adjust the number of columns as needed
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 87 / 130, // Adjust the aspect ratio
                ),
                itemCount: bookList.fields.books.length,
                itemBuilder: (context, index) {
                  // Assuming bookList.books contains image IDs or paths
                  int bookId = bookList.fields.books[index];
                  return Image.network(
                    // Replace the URL with the actual path or URL for the book image
                    'https://example.com/book_images/$bookId.jpg',
                    width: 87,
                    height: 130,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
