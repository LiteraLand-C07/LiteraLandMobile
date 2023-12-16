import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/models/book_queue.dart';
import 'package:litera_land_mobile/Admin/widgets/queue_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class QueueList extends StatefulWidget{
  const QueueList({Key? key}) : super(key: key);

  @override
  State<QueueList> createState() => _QueueList(); 
}

class _QueueList extends State<QueueList>{
  Future<List<BookQueue>> fetchBookQueue() async {
      final request = context.watch<CookieRequest>();
      var response = await request.get('https://literaland-c07-tk.pbp.cs.ui.ac.id/administrator/queues-json/');

      List<BookQueue> list_item = [];
      for (var d in response) {
          if (d != null) {
              list_item.add(BookQueue.fromJson(d));
          }
      }
      return list_item;
  }

  @override
  Widget build (BuildContext context){
    return FutureBuilder(
      future: fetchBookQueue(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data.isEmpty){
          return Center (child: Text("Tidak ada book queue"));
        }
        List<BookQueue> bookQueues = snapshot.data;
        return ListView.builder(
          itemCount: bookQueues.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: QueueCard(bookQueues[index]),
            );
          }
        );
      },
    );
  }
}