// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Discuss/screens/review.dart';
import 'package:litera_land_mobile/collections/models/detail_book.dart';
import 'package:litera_land_mobile/collections/widgets/form_collection.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DetailBookWidget extends StatefulWidget {
  final DetailBook book;
  final String linkCover;
  final int idBook;

  const DetailBookWidget(
      {super.key,
      required this.book,
      required this.idBook,
      this.linkCover = "https://i.imgur.com/CFVTM7y.png"});
  @override
  // ignore: library_private_types_in_public_api
  _DetailBookWidgetState createState() => _DetailBookWidgetState();
}

class _DetailBookWidgetState extends State<DetailBookWidget> {
  Future<List<dynamic>> fetchProduct() async {
    int id = widget.idBook;
    final request = context.watch<CookieRequest>();
    final response = await request.get(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/collections/check_collection_json/$id/');

    // melakukan konversi data json menjadi object Product
    List<dynamic> listItem = [];
    listItem.add(response[0]);

    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                color: const Color.fromARGB(255, 15, 15, 15),
                margin: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.network(
                                widget.linkCover,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.book.title,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Author: ${widget.book.author}',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Rating: ${widget.book.rating}/10',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Publisher: ${widget.book.publisher}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Total Pages: ${widget.book.pageCount}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Genres: ${widget.book.genre}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'ISBN: ${widget.book.isbn}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Language: ${widget.book.language}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Published Date: ${widget.book.publishedDate}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Description:',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              widget.book.description,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      if (request.loggedIn)
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (!snapshot.hasData)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .green), // Ubah warna tombol menjadi hijau
                                onPressed: () {
                                  _showFormModal(
                                    context,
                                    widget.book.pageCount,
                                    snapshot.data[0]["fields"]["rating"],
                                    snapshot.data[0]["fields"]["current_page"],
                                    snapshot.data[0]["fields"]["status_baca"],
                                  );
                                },
                                child: const Text('Add to collection',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            if (snapshot.hasData)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .green), // Ubah warna tombol menjadi hijau
                                onPressed: () {
                                  _showFormModal(
                                      context,
                                      widget.book.pageCount,
                                      snapshot.data[0]["fields"]["rating"],
                                      snapshot.data[0]["fields"]
                                          ["current_page"],
                                      snapshot.data[0]["fields"]
                                          ["status_baca"]);
                                },
                                child: const Text('Edit collection',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .blue), // Ubah warna tombol menjadi hijau
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BookListsPage()));
                              },
                              child: const Text('Review Book',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                    ],
                  ),
                )),
          );
        });
  }
}

void _showFormModal(BuildContext context, int max_page, int rating, int page,
    String status_baca) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Input Data'),
        content: CollectionFormModal(
            max_page: max_page,
            rating: rating,
            page: page,
            status_baca: status_baca),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup modal
            },
            child: const Text('Batal'),
          ),
        ],
      );
    },
  );
}
