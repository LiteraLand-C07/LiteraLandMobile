// ignore_for_file: non_constant_identifier_names
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:litera_land_mobile/Discuss/screens/review_list.dart';
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
        future: request.loggedIn ? fetchProduct() : Future.value(List.empty()),
        builder: (context, AsyncSnapshot snapshot) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300.0, // Adjust the height as needed
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.linkCover,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Column(
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
                      const SizedBox(height: 1.0),
                      Text(
                        'by ${widget.book.author} \n published by ${widget.book.publisher}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Center(
                          child: RatingBar.builder(
                        initialRating: widget.book.rating,
                        minRating: 0,
                        maxRating: 10,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 10,
                        itemSize: 15.0,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        unratedColor: Colors.white,
                        onRatingUpdate: (rating) {
                          // Handle rating updates if needed
                        },
                      )),
                      const SizedBox(height: 10.0),
                      Center(
                        child: Wrap(
                          spacing: 8.0, // Adjust the spacing between genres
                          runSpacing: 8.0,
                          children: widget.book.genre.split(',').map((genre) {
                            return Chip(
                              label: Text(
                                genre.trim(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 113, 53, 240),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation:
                                  2.0, // Adjust the chip background color
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Center(
                          child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          Chip(
                            label: Text(
                              'Released : ${widget.book.publishedDate}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 2.0, // Adjust the chip background color
                          ),
                          Chip(
                            label: Text(
                              '${widget.book.pageCount.toString()} Pages',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 2.0, // Adjust the chip background color
                          ),
                        ],
                      )),
                      const SizedBox(height: 16.0),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 92, 92, 92),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  border: Border.all(
                                      color: Colors.white, width: 1.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
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
                                    const SizedBox(height: 10.0),
                                    ExpandableText(
                                      widget.book.description,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      maxLines: 12,
                                      expandText: 'show more',
                                      collapseText: 'show less',
                                      linkColor: Colors.amber,
                                    ),
                                  ],
                                ),
                              ))),
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
                                      snapshot.data[0]["fields"]
                                          ["current_page"],
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewsPage(
                                        bookId: widget.idBook,
                                      ),
                                    ));
                              },
                              label: const Text('Review Book',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                    ],
                  ),
                ])),
              )
            ],
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
