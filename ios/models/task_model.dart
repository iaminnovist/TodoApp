class TaskModel {
  final String title;
  final String description;
  final DateTime dueDate;
  final String time;
  final String priority;

  TaskModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.time,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'time': time,
      'priority': priority,
    };
  }
}
