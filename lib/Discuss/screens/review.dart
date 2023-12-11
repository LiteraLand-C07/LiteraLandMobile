import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BookLists/widgets/book_lists_widget.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:litera_land_mobile/BookLists/models/book_lists_models.dart';

class BookListsPage extends StatefulWidget {
  const BookListsPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BookListsPageState createState() => _BookListsPageState();
}

class _BookListsPageState extends State<BookListsPage> {
  Future<List<BookLists>> fetchBookLists() async {
    final request = context.watch<CookieRequest>();
    final response =
        await request.get('https://literaland-c07-tk.pbp.cs.ui.ac.id/forumDiskusi/show_json/');

    List<BookLists> listItem = [];
    for (var d in response) {
      if (d != null) {
        listItem.add(BookLists.fromJson(d));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      appBar: AppBar(
        title: const Text('Review Lists'),
        backgroundColor:
            const Color.fromARGB(255, 15, 15, 15), // Dark themed AppBar color
        foregroundColor: Colors.white, // Text color for AppBar
      ),
      body: FutureBuilder(
          future: fetchBookLists(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "Tidak ada data produk.",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          child:
                              BookListsWidget(bookList: snapshot.data[index]),
                        ),
                      );
                    },
                  ),
                );
              }
            }
          }),
    );
  }
}
