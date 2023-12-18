// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/models/book_request.dart';
import 'package:litera_land_mobile/Admin/widgets/request_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class Inbox extends StatefulWidget{
  const Inbox({Key? key}) : super(key: key);

  @override
  State<Inbox> createState() => _Inbox(); 
}

class _Inbox extends State<Inbox>{
  Future<List<BookRequest>> fetchBookRequest() async {
      final request = context.watch<CookieRequest>();
      var response = await request.get('https://literaland-c07-tk.pbp.cs.ui.ac.id/administrator/request-json');

      List<BookRequest> list_item = [];
      for (var d in response) {
          if (d != null) {
              list_item.add(BookRequest.fromJson(d));
          }
      }
      return list_item;
  }

  @override
  Widget build (BuildContext context){
    return FutureBuilder(
      future: fetchBookRequest(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data.isEmpty){
          return const Center (
            child: Text(
              "Tidak ada book request",
              style: TextStyle(color: Colors.white),
            )
          );
        }
        List<BookRequest> bookRequest = snapshot.data;
        return ListView.builder(
          itemCount: bookRequest.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: RequestCard(bookRequest[index]),
            );
          }
        );
      },
    );
  }
}