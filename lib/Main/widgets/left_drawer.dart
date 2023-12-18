// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/screens/admin.dart';
import 'package:litera_land_mobile/BrowseBooks/screens/browse_books_page.dart';
import 'package:litera_land_mobile/Main/screens/login.dart';
import 'package:litera_land_mobile/Main/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 30, 29, 29),
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
          if (request.loggedIn && request.cookies.containsKey("isAdmin") && request.cookies["isAdmin"]!.value == "1")
            ListTile(
              iconColor: Colors.white,
              leading: const Icon(Icons.add),
              title: const Text(
                'Add Books to Database',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminPage(),
                    ),
                );
              },
            ),

          // Menampilkan item "Login" dan "Register" jika belum login
          if (!request.loggedIn)
            ListTile(
              iconColor: Colors.white,
              leading: const Icon(Icons.login),
              title: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
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
              iconColor: Colors.white,
              leading: const Icon(Icons.person_add),
              title:
                  const Text('Register', style: TextStyle(color: Colors.white)),
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
          // Menampilkan item "Logout" jika sudah login
          if (request.loggedIn)
            ListTile(
              iconColor: Colors.white,
              leading: const Icon(Icons.exit_to_app),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () async {
                final response = await request.logout(
                    "https://literaland-c07-tk.pbp.cs.ui.ac.id/auth/logout/");
                String message = response["message"];
                if (response['status']) {
                  request.cookies.remove("isAdmin");
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname."),
                  ));
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BrowseBooksPage()),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(message),
                  ));
                }
              },
            ),
        ],
      ),
    );
  }
}
