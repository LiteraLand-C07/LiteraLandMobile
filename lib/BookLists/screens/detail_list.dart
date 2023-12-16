import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:litera_land_mobile/BookLists/models/book_lists_models.dart';

class DetailPage extends StatelessWidget {
  final BookLists bookList;

  const DetailPage({Key? key, required this.bookList}) : super(key: key);

  Future<List<String>> fetchBookTitles(List<int> pkList) async {
    final response = await http.get(
        Uri.parse('https://literaland-c07-tk.pbp.cs.ui.ac.id/authentication/json/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Check if the data is not empty
      if (data.isNotEmpty) {
        final List<String> titles = data
            .where(
                (item) => item['fields'] != null && item['fields']['title'] != null && pkList.contains(item['pk']))
            .map((item) => item['fields']['title'].toString())
            .toList();

        if (titles.isNotEmpty) {
          return titles;
        } else {
          throw Exception('No valid book titles found in the data for the given primary keys');
        }
      } else {
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Failed to load book titles');
    }
  }

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
              bookList.fields.name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white, // Set the RGB color
              ),
            ),
            const SizedBox(height: 8),
            Text(
              bookList.fields.description,
              style: const TextStyle(fontSize: 16, color: Colors.white), // Adjust text color as needed
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color.fromARGB(255, 40, 40, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<String>>(
                  future: fetchBookTitles(bookList.fields.books),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No book titles available.');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: bookList.fields.books.length,
                        itemBuilder: (context, index) {
                          String bookTitle = snapshot.data![index];
                          return ListTile(
                            title: Text(
                              bookTitle,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
