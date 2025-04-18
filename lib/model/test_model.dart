class TaskModel {
  final String title;
  final String description;
  final DateTime dueDate;
  final String time;
  final String? id;
  final String priority;

  TaskModel({
    required this.title,
    required this.description,
    required this.dueDate,
     this.id,
    required this.time,
    required this.priority,
  });

  /// Convert to Firestore/Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'time': time,
      'priority': priority,
    };
  }

  /// Create from Firestore/Map
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      time: map['time'] ?? '',
      id: map['id'] ?? '',
      priority: map['priority'] ?? '',
    );
  }

  /// Convert to JSON
  String toJson() => toMap().toString();

  /// Create from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel.fromMap(json);
  }
}
