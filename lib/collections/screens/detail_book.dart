// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Main/widgets/bottom_navbar.dart';
import 'package:litera_land_mobile/collections/models/detail_book.dart';
import 'package:litera_land_mobile/collections/screens/mycollection.dart';
import 'package:litera_land_mobile/collections/widgets/card_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BookDetailPage extends StatefulWidget {
  final int bookId;
  bool isFromCollection;

  BookDetailPage(
      {Key? key, required this.bookId, this.isFromCollection = false})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  Future<List<dynamic>> fetchProduct() async {
    final request = context.watch<CookieRequest>();
    final response = await request.get(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/collections/get_detail_json/${widget.bookId}/');

    // melakukan konversi data json menjadi object Product
    List<dynamic> listItem = [];
    for (var d in response) {
      if (d != null) {
        listItem.add(DetailBook.fromJson(d));
      }
    }

    // Mengambil link cover buku
    var url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=isbn:${listItem[0].isbn}');
    var response2 = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response2.bodyBytes));
    String item = data["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"];
    item = item.replaceAll('zoom=1', 'zoom=2');

    listItem.add(item);

    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 67, 66, 66),
        appBar: AppBar(
          title: const Text('Book Detail'),
          backgroundColor: const Color.fromARGB(255, 15, 15, 15),
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (widget.isFromCollection) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CollectionPage()),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        bottomNavigationBar: const MyBottomNavigationBar(
          selectedIndex: 2,
        ),
        //drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: DetailBookWidget(
                        book: snapshot.data[0],
                        linkCover: snapshot.data[1],
                        idBook: widget.bookId,
                        isFromCollection: widget.isFromCollection,
                      )));
                }
              }
            }));
  }
}
