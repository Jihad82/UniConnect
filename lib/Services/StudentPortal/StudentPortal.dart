import 'package:flutter/material.dart';
import 'package:uniconnect/CustomDesign/custom_navbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/colors.dart';

class StudentPortal extends StatefulWidget {
  const StudentPortal({super.key});

  @override
  _StudentPortalState createState() => _StudentPortalState();
}

class _StudentPortalState extends State<StudentPortal> {
  late final WebViewController _controller;

  bool _isLoading = true;
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
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://green.edu.bd/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://studentportal.green.edu.bd/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('Student Portal', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.PrimaryColors),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.PrimaryColors),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
