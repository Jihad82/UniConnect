import 'package:flutter/material.dart';
import 'NoticeDetailsPage.dart';

class NoticesCards extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String? imageUrl;
  final String webUrl;

  const NoticesCards({
    required this.title,
    required this.date,
    required this.description,
    this.imageUrl,
    required this.webUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoticeDetailsPage(
              title: title.isEmpty ? 'No Title' : title,
              date: date.isEmpty ? 'No Date' : date,
              description: description.isEmpty ? 'No Description' : description,
              imageUrl: imageUrl,
              webUrl: webUrl.isEmpty ? '' : webUrl,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null && imageUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      height: 150,
                      width: double.infinity,
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                title.isEmpty ? 'No Title' : title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                date.isEmpty ? 'No Date' : date,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                description.isEmpty ? 'No Description' : description,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
