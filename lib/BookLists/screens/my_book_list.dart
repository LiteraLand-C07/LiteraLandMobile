import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BookLists/screens/book_list_form.dart';
import 'package:litera_land_mobile/BookLists/screens/book_lists.dart';
import 'package:litera_land_mobile/BookLists/screens/detail_list.dart';
import 'package:litera_land_mobile/BookLists/widgets/book_lists_widget.dart';
import 'package:litera_land_mobile/Main/widgets/bottom_navbar.dart';
import 'package:litera_land_mobile/Main/widgets/left_drawer.dart';
import 'package:litera_land_mobile/BookLists/models/book_lists_models.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyBookListsPage extends StatefulWidget {
  const MyBookListsPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MyBookListsPageState createState() => _MyBookListsPageState();
}

class _MyBookListsPageState extends State<MyBookListsPage> {
  Future<List<BookLists>> fetchBookLists() async {
    final request = context.watch<CookieRequest>();
    final response = await request
        .get('http://127.0.0.1:8000/rankingBuku/get_my_book_lists/');

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
        title: const Text('Book Lists'),
        backgroundColor:
            const Color.fromARGB(255, 15, 15, 15), // Dark themed AppBar color
        foregroundColor: Colors.white, // Text color for AppBar
      ),
      drawer: const LeftDrawer(),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 1,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyBookListsPage()),
                  );
                },
                child: const Text('Your List',
                    style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle the second button press
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookListsPage()),
                  );
                },
                child: const Text('Explore Others',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
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
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
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
                          return GestureDetector(
                              onTap: () {
                                // Handle navigation to the detail page for the selected item
                                // You can replace DetailPage with the actual page you want to navigate to
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        bookList: snapshot.data[index]),
                                  ),
                                );
                              },
                              child: Card(
                                color: const Color.fromARGB(255, 15, 15, 15),
                                elevation: 4,
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      BookListsWidget(
                                          bookList: snapshot.data[index]),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () async {
                                            // Get the collectionId to be deleted
                                            int id = snapshot.data[index].pk;

                                            // Send a delete request to the server
                                            final request = context.read<CookieRequest>();
                                            final response = await request.post(
                                                'http://127.0.0.1:8000/rankingBuku/delete-booklist-flutter/$id/', "");

                                            // Check if the deletion was successful
                                            if (response['status'] == 'success') {
                                              setState(() {
                                                snapshot.data.removeAt(index);
                                              });
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Terdapat kesalahan, silakan coba lagi."),
                                              ));
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                    );
                  }
                }
              }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle navigation to the page for adding a new product
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const BookListFormPage()), 
          );
        },
        backgroundColor: const Color.fromARGB(255, 170, 187, 204),
        child: const Icon(Icons.add),
      ),
    );
  }
}
