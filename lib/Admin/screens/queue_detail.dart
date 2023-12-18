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
      return jsonData["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"].replaceAll('zoom=1', 'zoom=6');
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
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      endDrawer: const RightDrawer(),
      floatingActionButton: FloatingActionButton(
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
        tooltip: 'Delete Review',
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getCover(), 
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                String cover = snapshot.data;
                return Image.network(
                    cover,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                );
              }
            ),
            Card(
              color: const Color.fromARGB(255, 42, 42, 42),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.bookQueue.fields.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
                    const SizedBox(height: 5),
                    Text(
                      widget.bookQueue.fields.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),  
              )
            )
          ],
        ),
      ) 
    );
  }
}