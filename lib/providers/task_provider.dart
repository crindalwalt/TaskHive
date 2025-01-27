import 'package:flutter/material.dart';
import 'package:task_hive/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = fakeTasks; // Internal list of tasks.

  // Getter for tasks
  List<Task> get tasks => [..._tasks];

  // Get task by ID
  Task getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  // Add a new task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners(); // Notify listeners to update UI.
  }

  // Update an existing task
  void updateTask(String id, Task updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      notifyListeners();
    }
  }

  // Toggle task completion
  void toggleTaskCompletion(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  // Delete a task
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  int getCompletedTaskCount() {
    return getCompletedTasks().length;
  }

  int getPendingTaskCount() {
    return getPendingTasks().length;
  }

  int getTotalTaskCount() {
    return _tasks.length;
  }

  // Filtered tasks (e.g., completed or pending)
  List<Task> getCompletedTasks() {
    return _tasks.where((task) => task.isCompleted).toList();
  }

  List<Task> getPendingTasks() {
    return _tasks.where((task) => !task.isCompleted).toList();
  }
}
