import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:litera_land_mobile/BrowseBooks/models/book.dart'; // Import the Book class
import 'package:litera_land_mobile/BrowseBooks/screens/user_requests_page.dart';
import 'package:litera_land_mobile/BrowseBooks/widgets/book_list_tile.dart';
import 'package:litera_land_mobile/BrowseBooks/widgets/request_book_dialog.dart';
import 'package:litera_land_mobile/Main/screens/login.dart';
import 'package:litera_land_mobile/Main/widgets/bottom_navbar.dart';
import 'package:litera_land_mobile/Main/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart'; // Import the BookListTile widget

class BrowseBooksPage extends StatefulWidget {
  final String query;
  const BrowseBooksPage({super.key, this.query = ""});

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

  void _showLoginAlert(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Required'),
          content:
              const Text('You need to be logged in to view your requests.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
                // Assuming LoginPage() is the page where the user can login.
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                onSubmitted: (String value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BrowseBooksPage(query: value.toLowerCase())),
                  );
                },
                decoration: InputDecoration(
                  labelText: 'Search Book by Title',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      // Remove the border
                      borderRadius: BorderRadius.circular(10.0)),
                  filled: true,
                  fillColor: Colors.black,
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.white,
                ),
              ),
            ),
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
                        if (book.title.toLowerCase().contains(widget.query)) {
                          return BookListTile(
                            book: book,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0), // Menambahkan padding horizontal
              child: Column(
                children: [
                  const Text(
                    'Your book is not here?',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8), // Mengurangi ukuran spasi
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      final request =
                          Provider.of<CookieRequest>(context, listen: false);
                      if (request.loggedIn) {
                        showRequestBookDialog(context, request);
                      } else {
                        _showLoginAlert(
                            context); // Menampilkan dialog atau mengarahkan ke halaman login
                      }
                    },
                    child: const Text('Request new book'),
                  ),
                  const SizedBox(height: 16), // Menambahkan spasi antara tombol
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, // Warna teks tombol
                      backgroundColor: Colors.white, // Warna latar tombol
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      // Menggunakan Navigator untuk berpindah ke halaman UserRequestsPage
                      if (request.loggedIn) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserRequestsPage(
                              request: Provider.of<CookieRequest>(context,
                                  listen: false)),
                        ));
                      } else {
                        _showLoginAlert(context);
                      }
                    },
                    child: const Text('View My Requests'),
                  ),
                ],
              ),
            ),
          ], // Add this closing bracket
        ));
  }
}
