import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BrowseBooks/widgets/success_dialog.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';  // Pastikan Anda mengimpor package provider

// Tambahkan parameter CookieRequest pada fungsi
void showRequestBookDialog(BuildContext context, CookieRequest request) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Request New Book'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              TextFormField(
                controller: authorController,
                decoration: const InputDecoration(hintText: 'Author'),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Submit'),
            onPressed: () async {
              // Menggunakan metode postJson dari CookieRequest
              final response = await request.postJson(
                "https://literaland-c07-tk.pbp.cs.ui.ac.id/create-flutter/",
                jsonEncode({
                  'title': titleController.text,
                  'author': authorController.text,
                  'description': descriptionController.text,
                }),
              );

              if (response['status'] == 'success') {
                // Handle success
                Navigator.of(context).pop(); // Menutup dialog permintaan buku
                showSuccessDialog(context); // Menampilkan dialog sukses
              } else {
                // Handle error based on the server's response
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${response['message']}")),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
