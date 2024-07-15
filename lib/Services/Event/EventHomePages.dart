import 'package:flutter/material.dart';
import 'package:uniconnect/CustomDesign/AppBar.dart';
import 'package:uniconnect/CustomDesign/custom_navbar.dart';
import 'package:uniconnect/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Eventhomepages extends StatelessWidget {
  const Eventhomepages({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Events and Seminars', showBackArrow: true, actionWidgets: []),
      bottomNavigationBar: const CustomNavBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Featured Events'),
            _buildFeaturedEvents(context),
            const SizedBox(height: 16.0),
            _buildSectionTitle(context, 'Upcoming Events and Seminars'),
            _buildUpcomingEvents(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedEvents(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('featured_events').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Text('No Featured Events Found');
        }
        final events = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: events.map((event) => _buildFeaturedEvent(context, event)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedEvent(BuildContext context, Map<String, dynamic> event) {
    return Container(
      width: 300, // Fixed width for each card
      margin: const EdgeInsets.only(right: 16.0),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              color: Colors.grey[300],
              child: Center(child: Image.network(event['image'] ?? 'default_image_url', fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event['title'] ?? 'No Title', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    event['subtitle'] ?? 'No Subtitle',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.PrimaryColors,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['date']?.split(' ')[0] ?? 'No Date',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              event['date']?.split(' ')[1] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final url = event['registration_url'] ?? '';
                          if (url.isNotEmpty && await canLaunch(url)) {
                            await launch(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Could not launch $url')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.PrimaryColors, // Background color
                        ),
                        child: const Text(
                          'Registrations',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingEvents(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('upcoming_events').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Text('No Upcoming Events Found');
        }
        final events = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        return Column(
          children: events.map((event) => _buildUpcomingEvent(context, event)).toList(),
        );
      },
    );
  }

  Widget _buildUpcomingEvent(BuildContext context, Map<String, dynamic> event) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 56,
          width: 56,
          color: Colors.grey[300],
          child: Center(child: Image.network(event['image'] ?? 'default_image_url')),
        ),
        title: Text(event['title'] ?? 'No Title', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event['date'] ?? 'No Date'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () async {
            final url = event['registration_url'] ?? '';
            if (url.isNotEmpty && await canLaunch(url)) {
              await launch(url);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Could not launch $url')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.PrimaryColors, // Background color
          ),
          child: const Text('View', style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ),
    );
  }
}
