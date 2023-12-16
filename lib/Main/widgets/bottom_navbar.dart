// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BookLists/screens/book_lists.dart';
import 'package:litera_land_mobile/BrowseBooks/screens/browse_books_page.dart';
import 'package:litera_land_mobile/Main/screens/login.dart';
import 'package:litera_land_mobile/collections/screens/mycollection.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  const MyBottomNavigationBar({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  void _showLoginAlert(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: const Text('Anda harus login untuk mengakses Collection.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    int currentIndex = widget.selectedIndex;

    // Fungsi untuk melakukan navigasi berdasarkan indeks yang dipilih
    void navigateToPage(int index, bool isLogin) {
      if ((index == 2 || index == 3) && !isLogin) {
        _showLoginAlert(context);
        return; // Hentikan perpindahan halaman
      }

      setState(() {
        currentIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BrowseBooksPage()),
              (route) => false);
          break;
        case 1:
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BookListsPage()),
              (route) => false);
          break;
        case 2:
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const CollectionPage()),
              (route) => false);
          break;
      }
    }

    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white,
      currentIndex: currentIndex,
      onTap: (index) {
        navigateToPage(index, request.loggedIn);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Ranking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark),
          label: 'Collection',
        ),
      ],
    );
  }
}
