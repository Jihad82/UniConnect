class Task {
  int id;
  String title;
  DateTime date;
  String priority;
  int status; // 0 - Incomplete, 1 - Complete

  Task({
    required this.title,
    required this.date,
    required this.priority,
    required this.status,
    this.id = 0, // Initialize id with a default value
  });

  Task.withId({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'priority': priority,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      priority: map['priority'],
      status: map['status'],
    );
  }
}
