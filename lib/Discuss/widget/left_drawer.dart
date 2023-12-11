import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BrowseBooks/screens/browse_books_page.dart';
import 'package:litera_land_mobile/Discuss/screens/review_list.dart';
import 'package:litera_land_mobile/Main/screens/login.dart';
import 'package:litera_land_mobile/Main/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  final int bookId;
  const LeftDrawer({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'LiteraLand',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Explore, Read, Discuss: LiteraLand, Where Your Literary Journey Unfolds.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          // Menampilkan item "Login" dan "Register" jika belum login
          if (!request.loggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              },
            ),
          if (!request.loggedIn)
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Register'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          // Menampilkan item "Browse Book" jika sudah login
          if (request.loggedIn)
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Browse Book'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BrowseBooksPage()),
                  (route) => false,
                );
              },
            ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Review List'),
            // Bagian redirection ke Item Page
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewsPage(
                      bookId: bookId,
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
