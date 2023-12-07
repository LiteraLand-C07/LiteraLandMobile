// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class UserRequestsPage extends StatefulWidget {
  final CookieRequest request;

  const UserRequestsPage({Key? key, required this.request}) : super(key: key);

  @override
  _UserRequestsPageState createState() => _UserRequestsPageState();
}

class _UserRequestsPageState extends State<UserRequestsPage> {
  Future<List<dynamic>> fetchUserRequests() async {
    try {
      final request = context.watch<CookieRequest>();
      // CookieRequest harus menangani header autentikasi dengan benar
      final response = await request.get('https://literaland-c07-tk.pbp.cs.ui.ac.id/book-requests-json/');
      // print(response);
      // Cek status code dan parse body jika status code adalah 200 (OK)
      if (response != null) {
        return response;
      } else {
        throw Exception('Failed to load user requests');
      }
    } catch (e) {
      // Handle exceptions dari http calls atau JSON dsecoding
      throw Exception('Failed to load user requests with error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Book Requests'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUserRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No book requests found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var bookRequest = snapshot.data![index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(bookRequest['title'], style: const TextStyle(fontWeight: FontWeight.bold)), // Judul buku dengan font tebal
                      const SizedBox(height: 5), // Spasi vertikal antara judul dan nama penulis
                      Text('Author: ${bookRequest['author']}'), // Nama penulis
                      const SizedBox(height: 5), // Spasi vertikal antara nama penulis dan deskripsi
                      Text(bookRequest['description']), // Deskripsi buku
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
