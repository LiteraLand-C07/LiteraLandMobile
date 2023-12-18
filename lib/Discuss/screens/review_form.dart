// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Discuss/screens/review_list.dart';
import 'package:litera_land_mobile/Discuss/widget/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ItemFormPage extends StatefulWidget {
  final int bookId;
  const ItemFormPage({super.key, required this.bookId});

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _reviewerName = "";
  String _review = "";
  int _starRating = 0;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Review Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(
        bookId: widget.bookId,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  labelText: "Name",
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _reviewerName = value!;
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    // Menambahkan variabel yang sesuai
                    _reviewerName = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Name cannot be empty!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Rating",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  labelText: "Rating",
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType
                    .number, // Memastikan hanya angka yang dapat diinput
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    setState(() {
                      _starRating = int.parse(value);
                    });
                  }
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Rating cannot be empty!";
                  }
                  final numValue = int.tryParse(value);
                  if (numValue == null || numValue < 1 || numValue > 5) {
                    return "Rating must be a number between 1 and 5";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Review",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  labelText: "Review",
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    // Menambahkan variabel yang sesuai
                    _review = value!;
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    // Menambahkan variabel yang sesuai
                    _review = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Review cannot be empty!";
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Kirim ke Django dan tunggu respons
                      // DONE: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                      final response = await request.post(
                          "https://literaland-c07-tk.pbp.cs.ui.ac.id/forumDiskusi/create-flutter/",
                          jsonEncode(<String, String>{
                            'book': widget.bookId
                                .toString(), //INI GANTI AMA BUKU YANG LU BUTUHIN !
                            'review': _review,
                            'reviewer_name': _reviewerName,
                            'star_rating': _starRating.toString(),
                          }));
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("New item has been saved!"),
                        ));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewsPage(
                                    bookId: widget.bookId,
                                  )),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("ERROR, please try again!"),
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
      ),
    );
  }
}
