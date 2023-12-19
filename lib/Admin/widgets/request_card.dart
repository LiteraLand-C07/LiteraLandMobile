// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/models/book_request.dart';
import 'package:litera_land_mobile/Admin/screens/admin.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RequestCard extends StatelessWidget{
  final  BookRequest bookRequest;
  const RequestCard(this.bookRequest, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final request = context.watch<CookieRequest>();
    return Card (
      color: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
      child: InkWell(
        child: Padding (
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column (
            children: [
              Text(
                bookRequest.fields.title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.red,
                ),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () async {
                  await request.post(
                    'https://literaland-c07-tk.pbp.cs.ui.ac.id/administrator/delete-request-flutter/${bookRequest.pk}',
                    jsonEncode(<String, String>{
                            'something': 'something',
                          } 
                  ));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPage()));
                },
              ),
            ],
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                backgroundColor: Colors.grey,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookRequest.fields.title,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Author: ${bookRequest.fields.author}",
                          style: const TextStyle(
                            fontSize: 16.0
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Description:",
                          style: TextStyle(
                            fontSize: 16.0
                          ),
                        ),
                        Text(
                          bookRequest.fields.description,
                          style: const TextStyle(
                            fontSize: 16.0
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 20,
                            ),
                            label: const Text('Close'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}