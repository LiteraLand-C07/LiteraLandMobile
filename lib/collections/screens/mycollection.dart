// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Main/widgets/bottom_navbar.dart';
import 'package:litera_land_mobile/Main/widgets/left_drawer.dart';
import 'package:litera_land_mobile/collections/models/collection.dart';
import 'package:litera_land_mobile/collections/widgets/card_collection.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 5, vsync: this);

  Future<List<BookCollection>> fetchProduct(String category) async {
    final request = context.watch<CookieRequest>();
    final response = await request.get(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/collections/get_collections_json/');

    // melakukan konversi data json menjadi object Product
    List<BookCollection> listItem = [];
    for (var d in response) {
      if (d != null) {
        BookCollection bookCollection = BookCollection.fromJson(d);

        if (category == 'All' || bookCollection.statusBaca == category) {
          listItem.add(BookCollection.fromJson(d));
        }
      }
    }
    return listItem;
  }

  // Helper method to build a filtered ListView
  Widget _buildFilteredListView(String category) {
    return FutureBuilder(
      future: fetchProduct(category),
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
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: BookCollectionWidget(
                      bookCollection: snapshot.data[index],
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      appBar: AppBar(
        title: const Text('MyCollection'),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        foregroundColor: Colors.white,
        bottom: TabBar(
          indicatorColor: Colors.amberAccent,
          labelColor: Colors.white,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Completed'),
            Tab(text: 'Reading'),
            Tab(text: 'Dropped'),
            Tab(text: 'Plan to Read'),
          ],
          controller: _tabController,
        ),
      ),
      drawer: const LeftDrawer(),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 2,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFilteredListView('All'),
          _buildFilteredListView('C'),
          _buildFilteredListView('R'),
          _buildFilteredListView('D'),
          _buildFilteredListView('PR'),
        ],
      ),
    );
  }
}
