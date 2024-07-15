import 'package:flutter/material.dart';
import 'package:uniconnect/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeDetailsPage extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String? imageUrl;
  final String webUrl;

  const NoticeDetailsPage({
    required this.title,
    required this.date,
    required this.description,
    this.imageUrl,
    required this.webUrl,
    super.key,
  });

  void _launchURL() async {
    if (webUrl.isNotEmpty) {
      final uri = Uri.parse(webUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $webUrl';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.PrimaryColors),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Padding(
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              date.isEmpty ? 'No Date' : date,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              description.isEmpty ? 'No Description' : description,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            if (webUrl.isNotEmpty)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _launchURL,
                  child: const Text('View Details',style: TextStyle(color: Colors.white),),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
