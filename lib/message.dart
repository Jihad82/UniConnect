class Message {
  final String text;
  final bool isUser;
  final DateTime date; // Assuming this field based on the error

  Message({
    required this.text,
    required this.isUser,
    required this.date, required String message,
  });
}
