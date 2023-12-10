import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BookLists/screens/book_list_form.dart';
import 'package:litera_land_mobile/BookLists/screens/detail_list.dart';
import 'package:litera_land_mobile/BookLists/screens/my_book_list.dart';
import 'package:litera_land_mobile/BookLists/widgets/book_lists_widget.dart';
import 'package:litera_land_mobile/Main/widgets/bottom_navbar.dart';
import 'package:litera_land_mobile/Main/widgets/left_drawer.dart';
import 'package:litera_land_mobile/BookLists/models/book_lists_models.dart';
import 'package:http/http.dart' as http;

class BookListsPage extends StatefulWidget {
  const BookListsPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BookListsPageState createState() => _BookListsPageState();
}

class _BookListsPageState extends State<BookListsPage> {
  Future<List<BookLists>> fetchBookLists() async {
    var url = Uri.parse(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/rankingBuku/get-book-list-json/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<BookLists> listItem = [];
    for (var d in data) {
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
      body: Column(
        children: [

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
                          builder: (context) =>
                              const MyBookListsPage()), // Replace AddProductPage with your actual page
                    );
                  },
                  child: Text('Your List'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the second button press
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BookListsPage()), // Replace AddProductPage with your actual page
                    );
                  },
                  child: Text('Explore Others'),
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
                          return GestureDetector(
                              onTap: () {
                                // Handle navigation to the detail page for the selected item
                                // You can replace DetailPage with the actual page you want to navigate to
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(bookList: snapshot.data[index]),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: BookListsWidget(
                                      bookList: snapshot.data[index]),
                                ),
                            )
                          );
                        },
                      ),
                    );
                  }
                }
              }),
          )
          
          ]
        ), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle navigation to the page for adding a new product
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const BookListFormPage()), // Replace AddProductPage with your actual page
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add), // Choose a color for the button
      ),
    );
  }
}
