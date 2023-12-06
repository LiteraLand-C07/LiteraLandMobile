import 'dart:convert';
import 'package:litera_land_mobile/BookLists/screens/book_lists.dart';
import 'package:litera_land_mobile/Main/models/books.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;

class BookListFormPage extends StatefulWidget {
  const BookListFormPage({super.key});

  @override
  State<BookListFormPage> createState() => _BookListFormPageState();
}

class _BookListFormPageState extends State<BookListFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _description = "";
  String _access = "";
  List<int> _books = [];

  Future<List<Book>> fetchAllBooks() async {
    // Implement your logic to fetch all books from the database
    // For example, you might use an API call or a database query
    // Return a List<Book> based on your data
    final response = await http.get(
      Uri.parse(
          'https://literaland-c07-tk.pbp.cs.ui.ac.id/authentication/json/'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      final List<dynamic> jsonData = json.decode(response.body);
      List<Book> books = jsonData.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add BookList',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Book>>(
          future: fetchAllBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Book> bookLists = snapshot.data!;

              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Name: ",
                              labelText: "Name: ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _name = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Nama tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Description: ",
                              labelText: "Description: ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _description = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Deskripsi tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: "Who can see this list?",
                              labelText: "Access",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            value: _access,
                            items: [
                              DropdownMenuItem(
                                value: "public",
                                child: const Text("Public"),
                              ),
                              DropdownMenuItem(
                                value: "private",
                                child: const Text("Private"),
                              ),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                _access = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Access cannot be empty!";
                              }
                              return null;
                            },
                          ),
                        ),                        
                        
                      ]),
                    
                    
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
