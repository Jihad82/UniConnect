import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../CustomDesign/AppBar.dart';
import 'NotificationService.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.initialize().then((_) {
      setState(() {});
    });

    // Listen to changes in notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {});
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Notification', showBackArrow: true, actionWidgets: [],),
      body: ListView.builder(
        itemCount: _notificationService.notifications.length,
        itemBuilder: (context, index) {
          final notification = _notificationService.notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Card(
              elevation: 4.0,
              child: ListTile(
                title: Text(
                  notification['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  notification['body']!,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Image.asset('assets/images/remove-48.png', height: 24.0, width: 24.0),
                  onPressed: () {
                    setState(() {
                      _notificationService.notifications.removeAt(index);
                    });
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationDetailPage(
                        title: notification['title']!,
                        body: notification['body']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final String title;
  final String body;

  const NotificationDetailPage({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notification Detail', showBackArrow: true, actionWidgets: [],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(body),
          ],
        ),
      ),
    );
  }
}
