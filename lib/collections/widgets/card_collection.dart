import 'package:flutter/material.dart';
import 'package:litera_land_mobile/collections/models/collection.dart';
import 'package:litera_land_mobile/collections/screens/detail_book.dart';

class BookCollectionWidget extends StatelessWidget {
  final BookCollection bookCollection;

  const BookCollectionWidget({super.key, required this.bookCollection});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        color: Colors.white)), // Ubah warna teks menjadi putih
                const SizedBox(height: 10),
                Text('Genre: ${bookCollection.genre}',
                    style: const TextStyle(
                        color: Colors.white)), // Ubah warna teks menjadi putih
                const SizedBox(height: 10),
                Text(
                  'Page: ${bookCollection.currentPage}/${bookCollection.pageCount}',
                  style: const TextStyle(
                      color: Colors.white), // Ubah warna teks menjadi putih
                ),
                const SizedBox(height: 10),
                Text('Rating: ${bookCollection.rating}/10',
                    style: const TextStyle(
                        color: Colors.white)), // Ubah warna teks menjadi puti
                const SizedBox(height: 10),
                Text('Status: ${bookCollection.statusBacaDisplay}',
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 10), // Ubah warna teks menjadi putih
              ],
            ),
          ),
          ButtonBar(
            children: <Widget>[
              SizedBox(
                width: 100.0, // Lebar tombol
                height: 25.0, // Tinggi tombol
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue), // Ubah warna tombol menjadi hijau
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetailPage(
                                bookId: bookCollection.book,
                              )),
                    );
                  },
                  child: const Text('VIEW',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                width: 100.0, // Lebar tombol
                height: 25.0, // Tinggi tombol
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green), // Ubah warna tombol menjadi hijau
                  onPressed: () {/* ... */},
                  child: const Text('EDIT',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                width: 100.0, // Lebar tombol
                height: 25.0, // Tinggi tombol
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red), // Ubah warna tombol menjadi hijau
                  onPressed: () {/* ... */},
                  child: const Text('DELETE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
