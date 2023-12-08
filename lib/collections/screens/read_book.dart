import 'dart:async';

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Main/widgets/bottom_navbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyCustomWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  MyCustomWebView({
    super.key,
    required this.title,
    required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 67, 66, 66),
        appBar: AppBar(
          title: Text(title),
          backgroundColor: const Color.fromARGB(255, 15, 15, 15),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: const MyBottomNavigationBar(
          selectedIndex: 2,
        ),
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
