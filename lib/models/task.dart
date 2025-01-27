class Task {
  String id;
  String userId;
  String title;
  String description;
  bool isCompleted;
  DateTime dueDate;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueDate,
  });
}
