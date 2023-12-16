// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/collections/models/collection.dart';
import 'package:litera_land_mobile/collections/screens/detail_book.dart';
import 'package:litera_land_mobile/collections/screens/mycollection.dart';
import 'package:litera_land_mobile/collections/screens/read_book.dart';
import 'package:litera_land_mobile/collections/widgets/form_collection.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookCollectionWidget extends StatelessWidget {
  final BookCollection bookCollection;

  const BookCollectionWidget({super.key, required this.bookCollection});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          color: const Color.fromARGB(255, 15, 15, 15),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.book,
                    color: Colors.white), // Ubah warna ikon menjadi putih
                title: Text(
                  bookCollection.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white), // Ubah warna teks menjadi putih
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Text('Author: ${bookCollection.author}',
                        style: const TextStyle(
                            color:
                                Colors.white)), // Ubah warna teks menjadi putih
                    const SizedBox(height: 10),
                    Text('Genre: ${bookCollection.genre}',
                        style: const TextStyle(
                            color:
                                Colors.white)), // Ubah warna teks menjadi putih
                    const SizedBox(height: 10),
                    Text(
                      'Page: ${bookCollection.currentPage}/${bookCollection.pageCount}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold), // Ubah warna teks menjadi putih
                    ),
                    const SizedBox(height: 10),
                    Text('Rating: ${bookCollection.rating}/10',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight
                                .bold)), // Ubah warna teks menjadi puti
                    const SizedBox(height: 10),
                    Text('Status: ${bookCollection.statusBacaDisplay}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10), // Ubah warna teks menjadi putih
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12.0,
                runSpacing: 12.0,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(
                              bookId: bookCollection.book,
                              isFromCollection: true,
                            ),
                          ),
                        );
                      },
                      icon:
                          const Icon(Icons.remove_red_eye, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 197, 82, 75),
                      ),
                      onPressed: () {
                        int idHalaman = bookCollection.book;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCustomWebView(
                              title: bookCollection.title,
                              selectedUrl:
                                  "https://literaland-c07-tk.pbp.cs.ui.ac.id/collections/read_book_flutter/$idHalaman/",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chrome_reader_mode,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        _showFormModal(
                          context,
                          bookCollection.pageCount,
                          bookCollection.rating,
                          bookCollection.currentPage,
                          bookCollection.statusBaca,
                          "Edit Collection",
                          true,
                          bookCollection.book,
                          bookCollection.pk,
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        int collectionId = bookCollection.pk;
                        final request = context.read<CookieRequest>();
                        String url =
                            "https://literaland-c07-tk.pbp.cs.ui.ac.id/collections/delete_flutter/$collectionId/";
                        final response = await request.post(url, "");
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Buku berhasil dihapus dari daftar koleksi!"),
                          ));
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const CollectionPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
                        }
                      },
                      icon: const Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
            ],
          ),
        ));
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
    int collectionId) {
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
          isInCollection: true,
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
