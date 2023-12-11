// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:litera_land_mobile/BookLists/screens/book_lists.dart';
import 'package:litera_land_mobile/Main/models/books.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

const List<String> list = <String>['', 'public', 'private'];

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
  final List<int> _books = [];
  String dropdownValue = list.first;

  

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<List<Book>> fetchAllBooks() async {
    // Implement your logic to fetch all books from the database
    // For example, you might use an API call or a database query
    // Return a List<Book> based on your data
    
    final response = await request.get(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/authentication/json/');

    List<Book> listItem = [];
    for (var d in response) {
      if (d != null) {
        listItem.add(Book.fromJson(d));
      }
    }
    return listItem;
  
  }
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add BookList',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Book>>(
          future: fetchAllBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
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
                        const Text("Who can see this?"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownMenu<String>(
                            initialSelection: list.first,
                            onSelected: (String? value) {
                              // ketika user select an item
                              setState(() {
                                _access = value!;
                                dropdownValue = value;
                              });
                            },
                            dropdownMenuEntries: list
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                          ),
                        ),

                        const Text("Add Books"),
                        SizedBox(
                          height: 300, // Set a specific height
                          child: ListView.builder(
                            itemCount: bookLists.length,
                            itemBuilder: (context, index) {
                              final Book book = bookLists[index];
                              return CheckboxListTile(
                                title: Text(book.fields.title),
                                value: _books.contains(book.pk),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null) {
                                      if (value) {
                                        _books.add(book.pk);
                                      } else {
                                        _books.remove(book.pk);
                                      }
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Kirim ke Django dan tunggu respons
                                  final response = await request.postJson(
                                      "https://literaland-c07-tk.pbp.cs.ui.ac.id/create_booklist_flutter/",
                                      jsonEncode(<String, dynamic>{
                                        'name': _name,
                                        'description': _description,
                                        'access': _access,
                                        'books': _books, // belum bener sesuaiin sama books yang diambil harusnya
                                      }));

                                  if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Produk baru berhasil disimpan!"),
                                    ));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const BookListsPage()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Terdapat kesalahan, silakan coba lagi."),
                                    ));
                                  }
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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
