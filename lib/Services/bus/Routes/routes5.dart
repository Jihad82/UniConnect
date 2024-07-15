import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:uniconnect/utils/colors.dart';

class Route5Page extends StatefulWidget {
  const Route5Page({super.key});

  @override
  _Route5PageState createState() => _Route5PageState();
}

class _Route5PageState extends State<Route5Page> {
  String localPath = "";


  @override
  void initState() {
    super.initState();
    _preparePdf();
  }

  Future<void> _preparePdf() async {
    try {
      // Fetch the PDF URL from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('bus_pdfs').doc('route6').get();
      String pdfUrl = snapshot['url'];

      // Download the PDF from Firebase Storage
      final Reference ref = FirebaseStorage.instance.refFromURL(pdfUrl);
      final Uint8List? pdfData = await ref.getData();

      // Save the PDF to a local file
      final Directory tempDir = await getTemporaryDirectory();
      final File file = File('${tempDir.path}/route6.pdf');
      await file.writeAsBytes(pdfData as List<int>, flush: true);

      setState(() {
        localPath = file.path;
      });
    } catch (e) {
      print("Error fetching PDF: $e");
    }
  }

  Future<void> _downloadPdf() async {
    if (await Permission.storage.request().isGranted) {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        final String newPath = '$selectedDirectory/route6.pdf';
        final File newFile = File(newPath);
        await newFile.writeAsBytes(await File(localPath).readAsBytes());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('PDF downloaded to $newPath'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Download location not selected'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.PrimaryColors),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Transportation Routes 6',
          style: TextStyle(
            color: AppColors.PrimaryColors,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.download,color: AppColors.PrimaryColors,),
            onPressed: _downloadPdf,
          ),
        ],
      ),
      body: localPath.isNotEmpty
          ? PDFView(
        filePath: localPath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        fitPolicy: FitPolicy.BOTH,
        onRender: (_pages) {
          setState(() {});
        },
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
      )
          : const Center(child: CircularProgressIndicator(
        color: AppColors.PrimaryColors,
      )),
    );
  }
}
