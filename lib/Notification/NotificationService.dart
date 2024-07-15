import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final List<Map<String, String>> _notifications = [];

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  NotificationService._internal();

  List<Map<String, String>> get notifications => _notifications;

  Future<void> initialize() async {
    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Get the initial message if the app was opened with a notification
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _handleMessage(RemoteMessage message) {
    if (message.notification != null) {
      _notifications.add({
        'title': message.notification!.title ?? "No title",
        'body': message.notification!.body ?? "No body"
      });
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationService()._handleMessage(message);
}
