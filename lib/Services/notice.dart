import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/Services/Notices/NoticeCard.dart';
import 'package:uniconnect/utils/colors.dart';
import '../CustomDesign/custom_navbar.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events & Notices', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.PrimaryColors),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('noticeboard').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.PrimaryColors,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
            );
          }

          final data = snapshot.requireData;

          if (data.size == 0) {
            return const Center(child: Text('No notices available.', style: TextStyle(fontSize: 16)));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.size,
            itemBuilder: (context, index) {
              final notice = data.docs[index];
              final title = notice.get('title') ?? 'No Title';
              final date = notice.get('date') ?? 'No Date';
              final description = notice.get('description') ?? 'No Description';
              final imageUrl = notice.get('imageUrl') as String?;
              final webUrl = notice.get('webUrl') ?? '';

              return NoticesCards(
                title: title,
                date: date,
                description: description,
                imageUrl: imageUrl,
                webUrl: webUrl,
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
