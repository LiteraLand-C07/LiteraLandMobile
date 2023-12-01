import 'package:flutter/material.dart';
import 'package:litera_land_mobile/collections/models/detail_book.dart';

class DetailBookWidget extends StatelessWidget {
  final DetailBook book;
  final String linkCover;

  const DetailBookWidget(
      {super.key,
      required this.book,
      this.linkCover = "https://i.imgur.com/CFVTM7y.png"});

  @override
  Widget build(BuildContext context) {
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
                          linkCover,
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
                                book.title,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Author: ${book.author}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Rating: ${book.rating}/10',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Publisher: ${book.publisher}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Total Pages: ${book.pageCount}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Genres: ${book.genre}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'ISBN: ${book.isbn}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Language: ${book.language}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Published Date: ${book.publishedDate}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
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
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        book.description,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green), // Ubah warna tombol menjadi hijau
                      onPressed: () {},
                      child: const Text('Add to collection',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue), // Ubah warna tombol menjadi hijau
                      onPressed: () {},
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
  }
}
