// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/models/book_queue.dart';
import 'package:litera_land_mobile/Admin/screens/admin.dart';
import 'package:litera_land_mobile/Admin/screens/queue_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class QueueCard extends StatelessWidget{
  final BookQueue bookQueue;
  const QueueCard(this.bookQueue, {Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column (
            children: [
              Text(
                bookQueue.fields.title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  await request.post(
                    'https://literaland-c07-tk.pbp.cs.ui.ac.id/administrator/delete-queue-flutter/${bookQueue.pk}',
                    jsonEncode(<String, String>{
                            'something': 'something',
                          } 
                  ));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPage()));
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => QueueDetail(bookQueue)));
        }
      ),
    );
  }
}