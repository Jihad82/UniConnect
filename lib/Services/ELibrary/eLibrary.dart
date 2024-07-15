import 'package:flutter/material.dart';
import 'package:uniconnect/CustomDesign/custom_navbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/colors.dart';

class Elibrary extends StatefulWidget {
  const Elibrary({super.key});

  @override
  _ElibraryState createState() => _ElibraryState();
}

class _ElibraryState extends State<Elibrary> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://library.green.edu.bd/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://library.green.edu.bd/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-library', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.PrimaryColors),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: WebViewWidget(controller: _controller),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
