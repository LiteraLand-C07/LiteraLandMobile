// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/models/book_queue.dart';
import 'package:litera_land_mobile/Admin/widgets/right_drawer.dart';
import 'package:litera_land_mobile/Main/widgets/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:litera_land_mobile/Admin/screens/admin.dart';

class QueueDetail extends StatefulWidget{
  final BookQueue bookQueue;
  const QueueDetail(this.bookQueue, {Key? key}) : super(key: key);

  @override
  State<QueueDetail> createState() => _QueueDetail();
}

class _QueueDetail extends State<QueueDetail>{
  Future<String> getCover() async {
    try {
      String isbn = widget.bookQueue.fields.isbn;
      var url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonData["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"];
    }
    catch (e){
      return "https://i.imgur.com/CFVTM7y.png";
    }
  }

  @override
  Widget build(BuildContext context){
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Queue Detail'),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15), // Dark themed AppBar color
        foregroundColor: Colors.white, // Text color for AppBar
      ),
      drawer: const LeftDrawer(),
      endDrawer: const RightDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child:  SingleChildScrollView(
                child: Card(
                  color: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder(
                              future: getCover(), 
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }

                                String cover = snapshot.data;
                                return Expanded(
                                  child: Image.network(
                                    cover,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.bookQueue.fields.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Author: ${widget.bookQueue.fields.author}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Publisher: ${widget.bookQueue.fields.publisher}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Genre: ${widget.bookQueue.fields.genre}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Language: ${widget.bookQueue.fields.language}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Page count: ${widget.bookQueue.fields.pageCount}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Description:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      widget.bookQueue.fields.description,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ]
                                ),
                              ) 
                            )
                          ],
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () async {
                            await request.post(
                              'https://literaland-c07-tk.pbp.cs.ui.ac.id/administrator/delete-queue-flutter/${widget.bookQueue.pk}',
                              jsonEncode(<String, String>{
                                      'something': 'something',
                                    } 
                            ));
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPage()));
                          },
                          child: const Text('Delete'),
                        ),
                      ]
                    ),
                  ) ,
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  textStyle: const TextStyle(fontSize: 16),
                ),
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("Back")
            ),
          )
        ],
      )
    );
  }
}