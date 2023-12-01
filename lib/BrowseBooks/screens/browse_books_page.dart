import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:litera_land_mobile/collections/models/collection.dart';
import 'package:litera_land_mobile/BrowseBooks/models/book.dart'; // Import the Book class
import 'package:litera_land_mobile/BrowseBooks/widgets/book_list_tile.dart'; // Import the BookListTile widget

class BrowseBooksPage extends StatefulWidget {
  @override
  _BrowseBooksPageState createState() => _BrowseBooksPageState();
}

class _BrowseBooksPageState extends State<BrowseBooksPage> {
  Future<List<BookCollection>> fetchBooks() async {
    final request = context.watch<CookieRequest>();
    final response = await request.get('https://www.googleapis.com/books/v1/volumes?q=flutter&fields=items(volumeInfo(title,authors,categories))');

    if (response.statusCode == 200) {
      final List<dynamic> booksJson = json.decode(response.body)['items'];
      // Assuming your BookCollection model has a constructor that accepts title, authors, and categories (genres)
      return booksJson.map((jsonItem) => BookCollection.fromJson({
        'title': jsonItem['volumeInfo']['title'],
        'authors': jsonItem['volumeInfo']['authors'],
        'categories': jsonItem['volumeInfo']['categories']
      })).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      appBar: AppBar(
        title: const Text('Browse Books'),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15), // Dark themed AppBar color
        foregroundColor: Colors.white, // Text color for AppBar
      ),
      body: Column(
        children: [
          FutureBuilder<List<BookCollection>>(
            future: fetchBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No books found'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final book = snapshot.data![index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text('Subtitle'),
                      onTap: () {
                        // TODO: Navigate to book details page
                        // Add your onTap action here
                      },
                    );
                  },
                );
              }
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0), // Add padding around the text and button
            child: Column(
              children: [
                const Text(
                  'Your book is not here?',
                  style: TextStyle(
                    color: Colors.white70, // Lighter text color for visibility
                    fontSize: 18, // Adjust the font size as needed
                  ),
                ),
                const SizedBox(height: 16), // Space between text and button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white, // Button text color
                    textStyle: const TextStyle(fontSize: 16), // Adjust text style of the button
                  ),
                  onPressed: () {
                    // TODO: Implement the action when the button is pressed
                  },
                  child: const Text('Request new book'),
                ),
              ],
            ),
          ),
        ], // Add this closing bracket
      
    ));
  }
}


