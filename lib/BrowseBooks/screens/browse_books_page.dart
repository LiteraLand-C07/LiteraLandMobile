import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:litera_land_mobile/BrowseBooks/models/book.dart'; // Import the Book class
import 'package:litera_land_mobile/BrowseBooks/widgets/book_list_tile.dart';
import 'package:litera_land_mobile/Main/widgets/bottom_navbar.dart';
import 'package:litera_land_mobile/Main/widgets/left_drawer.dart'; // Import the BookListTile widget

class BrowseBooksPage extends StatefulWidget {
  const BrowseBooksPage({super.key});

  @override
  BrowseBooksPageState createState() => BrowseBooksPageState();
}

class BrowseBooksPageState extends State<BrowseBooksPage> {
  Future<List<Book>> fetchBooks() async {
    var url = Uri.parse(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/authentication/json/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final List<dynamic> booksJson = json.decode(response.body);
      return booksJson.map((jsonItem) => Book.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 103, 101, 101),
        appBar: AppBar(
          title: const Text('Browse Books'),
          backgroundColor:
              const Color.fromARGB(255, 15, 15, 15), // Dark themed AppBar color
          foregroundColor: Colors.white, // Text color for AppBar
        ),
        drawer: const LeftDrawer(),
        bottomNavigationBar: const MyBottomNavigationBar(
          selectedIndex: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Book>>(
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
                        return BookListTile(
                          book: book,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                  16.0), // Add padding around the text and button
              child: Column(
                children: [
                  const Text(
                    'Your book is not here?',
                    style: TextStyle(
                      color:
                          Colors.white70, // Lighter text color for visibility
                      fontSize: 18, // Adjust the font size as needed
                    ),
                  ),
                  const SizedBox(height: 16), // Space between text and button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white, // Button text color
                      textStyle: const TextStyle(
                          fontSize: 16), // Adjust text style of the button
                    ),
                    onPressed: () {
                      // implement nanti
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
