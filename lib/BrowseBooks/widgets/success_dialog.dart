import 'package:flutter/material.dart';
import 'package:litera_land_mobile/BrowseBooks/screens/user_requests_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Request Submitted'),
        content: const Text('Your book request has been successfully submitted.'),
        actions: <Widget>[
          TextButton(
            child: const Text('View My Requests'),
            onPressed: () {
              Navigator.of(context).pop();

              // Mendapatkan CookieRequest dari Provider
              final request = Provider.of<CookieRequest>(context, listen: false);

              // Navigasi ke UserRequestsPage dengan memberikan CookieRequest
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserRequestsPage(request: request),
              ));
            },
          ),
        ],
      );
    },
  );
}
