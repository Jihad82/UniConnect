import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uniconnect/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'dart:async';

import '../../CustomDesign/AppBar.dart';
import '../../CustomDesign/custom_navbar.dart';

class Victimization extends StatelessWidget {
  const Victimization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Victimization',
        showBackArrow: true,
        actionWidgets: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: const Icon(Icons.email, color: AppColors.PrimaryColors),
                  title: const Text('Send Email'),
                  onTap: () {
                    Navigator.pop(context);  // Close the menu
                    _composeEmail(context);
                  },
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: const Icon(Icons.file_download, color: AppColors.PrimaryColors),
                  title: const Text('Download Policy PDF'),
                  onTap: () {
                    Navigator.pop(context);  // Close the menu
                    _downloadPolicyPDF(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemCount: 2, // Adjusted to show only one item initially
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildGridItem(
              context,
              icon: Icons.picture_as_pdf,
              label: 'View Harassment Policy',
              onPressed: () {
                _viewPolicyPDF(context);
              },
            );

          } else {
            return _buildGridItem(
              context,
              icon: Icons.email,
              label: 'Send Email',
              onPressed: () {
                _composeEmail(context);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50.0, color: AppColors.PrimaryColors),
            const SizedBox(height: 10.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _viewPolicyPDF(BuildContext context) async {
    try {
      ByteData data = await rootBundle.load('assets/pdf/sexual_harassment_policy.pdf');
      Uint8List bytes = data.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/sexual_harassment_policy.pdf').create();
      await file.writeAsBytes(bytes);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerPage(filePath: file.path),
        ),
      );
    } catch (e) {
      print('Error opening PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error opening PDF'),
        ),
      );
    }
  }

  Future<void> _downloadPolicyPDF(BuildContext context) async {
    try {
      ByteData data = await rootBundle.load('assets/pdf/sexual_harassment_policy.pdf');
      Uint8List bytes = data.buffer.asUint8List();
      final tempDir = await getExternalStorageDirectory();
      final file = await File('${tempDir!.path}/sexual_harassment_policy.pdf').create();
      await file.writeAsBytes(bytes);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Policy PDF downloaded successfully'),
        ),
      );
    } catch (e) {
      print('Error downloading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error downloading PDF'),
        ),
      );
    }
  }

  void _composeEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'complaints.shcc@green.edu.bd',
      queryParameters: {
        'subject': '',
        'body': '',
      },
    );

    try {
      await launch(emailLaunchUri.toString());
    } catch (e) {
      print('Error launching email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error launching email'),
        ),
      );
    }
  }
}

class PDFViewerPage extends StatelessWidget {
  final String filePath;

  const PDFViewerPage({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policy PDF',style: TextStyle(
          fontSize: 16,
          color: AppColors.PrimaryColors
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              _downloadFile(context, filePath);
            },
          ),
        ],
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }

  void _downloadFile(BuildContext context, String filePath) async {
    try {
      final file = File(filePath);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Downloading PDF...'),
        ),
      );
      // Simulate download delay
      await Future.delayed(Duration(seconds: 2));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF Downloaded'),
        ),
      );
      // If you want to copy the file to external storage, you can add the necessary logic here
    } catch (e) {
      print('Error downloading file: $e');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error downloading PDF'),
        ),
      );
    }
  }
}
