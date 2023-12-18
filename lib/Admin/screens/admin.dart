// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/widgets/right_drawer.dart';
import 'package:litera_land_mobile/Main/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget{
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _author = "";
  String _description = "";
  String _publisher = "";
  int _pageCount = 0;
  String _genre = "";
  String _ISBN = "";
  String _language = "";
  String _publishedDate = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Books to Database'),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15), // Dark themed AppBar color
        foregroundColor: Colors.white, // Text color for AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      endDrawer: const RightDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Padding (
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Title",
                            labelText: "Title",
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _title = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Title not valid!";
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Author",
                            labelText: "Author",
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _author = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Author not valid!";
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Publisher",
                            labelText: "Publisher",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _publisher = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Publisher not valid!";
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Page count",
                            labelText: "Page count",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _pageCount = int.parse(value!);
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Page count not valid!";
                            }
                            if (int.tryParse(value) == null) {
                              return "Page count must be an integer!";
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Description",
                            labelText: "Description",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _description = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Description not valid!";
                            }
                            return null;
                          },
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Genre",
                            labelText: "Genre",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _genre = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Genre not valid!";
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "ISBN",
                            labelText: "ISBN",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _ISBN = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "ISBN not valid!";
                            }

                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Language",
                            labelText: "Language",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _language = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Language not valid!";
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Published Date",
                            labelText: "Published Date",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (String? value) {
                            setState(() {
                              _publishedDate = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Published Date not valid!";
                            }
                            try {
                              DateTime.parse(value);
                              return null;
                            }
                            catch (e) {
                              return "Published Date not valid!";
                            }
                          },
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=isbn:$_ISBN");
                              var response = await http.get(
                                url,
                                headers: {"Content-Type": "application/json"},
                              );
                              var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

                              if (jsonData["totalItems"] != 1){
                                showDialog(context: context, builder: (BuildContext) {
                                  return const AlertDialog(
                                    title: Text("Book Doesn't Exist"),
                                    content: Text("ISBN Invalid"),
                                  );
                                });
                              }
                              else {
                                if (_formKey.currentState!.validate()) {
                                  final response = await request.postJson(
                                  "https://literaland-c07-tk.pbp.cs.ui.ac.id/administrator/create-flutter/",
                                  jsonEncode(<String, String>{
                                      'title': _title,
                                      'author': _author,
                                      'description': _description,
                                      'publisher': _publisher,
                                      'page_count': _pageCount.toString(),
                                      'genre': _genre,
                                      'ISBN': _ISBN,
                                      'language': _language,
                                      'published_date': _publishedDate,
                                  }));

                                  if (response['status'] == 'already_exist'){
                                    ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text("Book already exist!"),
                                    ));

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const AdminPage()),
                                    );
                                  }
                                  else if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text("BookQueue baru berhasil disimpan!"),
                                    ));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const AdminPage()),
                                    );
                                  }
                                  else {
                                    ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text("Gagal menambahkan BookQueue baru!"),
                                    ));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const AdminPage()),
                                    );
                                  }
                                }
                              }

                            },
                            child: const Text(
                              'Add Book',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
              )
            ),
          )
        ],
      )
    );
  }
}