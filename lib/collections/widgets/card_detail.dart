// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/collections/models/detail_book.dart';
import 'package:litera_land_mobile/collections/widgets/form_collection.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DetailBookWidget extends StatefulWidget {
  final DetailBook book;
  final String linkCover;
  final int idBook;
  final bool isFromCollection;

  const DetailBookWidget(
      {super.key,
      required this.book,
      required this.idBook,
      this.linkCover = "https://i.imgur.com/CFVTM7y.png",
      this.isFromCollection = false});

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.book.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 10.0),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        widget.linkCover,
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                      )),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        Text(
                          'Author: ${widget.book.author}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Rating: ${widget.book.rating.toStringAsFixed(2)}/10',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Publisher: ${widget.book.publisher}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Total Pages: ${widget.book.pageCount}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Genres: ${widget.book.genre}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'ISBN: ${widget.book.isbn}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Language: ${widget.book.language}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Published Date: ${widget.book.publishedDate}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.book.description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  if (request.loggedIn)
                    ButtonBar(
                      buttonPadding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (!snapshot.hasData)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .green), // Ubah warna tombol menjadi hijau
                            onPressed: () {
                              _showFormModal(
                                  context,
                                  widget.book.pageCount,
                                  0,
                                  0,
                                  "PR",
                                  "Add to Collection",
                                  false,
                                  widget.idBook,
                                  -1,
                                  widget.isFromCollection);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: const Text('Add to collection',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        if (snapshot.hasData)
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
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
                                  "Edit Collection",
                                  true,
                                  widget.idBook,
                                  snapshot.data[0]["pk"],
                                  widget.isFromCollection);
                            },
                            label: const Text('Edit collection',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.reviews,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .blue), // Ubah warna tombol menjadi hijau
                          onPressed: () {},
                          label: const Text('Review Book',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        });
  }
}

void _showFormModal(
    BuildContext context,
    int max_page,
    int rating,
    int page,
    String status_baca,
    String judul,
    bool is_edit,
    int idBook,
    int collectionId,
    bool isFromCollection) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(judul),
        content: CollectionFormModal(
          max_page: max_page,
          rating: rating,
          page: page,
          status_baca: status_baca,
          is_edit: is_edit,
          bookId: idBook,
          collectionId: collectionId,
          isFromCollection: isFromCollection,
        ),
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
