import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

class UpcomingEventsAndNotices extends StatelessWidget {
  const UpcomingEventsAndNotices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Upcoming events & Notice',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const EventCard(
            iconData: Icons.sports_soccer,
            iconColor: Colors.yellow,
            title: 'Sports',
            subtitle: 'Football match at 3 PM',
          ),
          const SizedBox(height: 8),
          const EventCard(
            iconData: Icons.restaurant,
            iconColor: AppColors.PrimaryColors,
            title: 'Campus canteens Offers',
            subtitle: 'Variety of food options',
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/notice');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('View all'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final String title;
  final String subtitle;

  const EventCard({super.key,
    required this.iconData,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor,
          child: Icon(iconData, color: Colors.black54),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
