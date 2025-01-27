import 'package:uuid/uuid.dart';

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

final uuid = Uuid();
List<Task> fakeTasks = [
  Task(
    id: uuid.v4(),
    userId: 'user1',
    title: 'Complete Flutter project',
    description: 'Work on the homepage design and state management setup.',
    isCompleted: false,
    dueDate: DateTime.now().add(Duration(days: 2)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user1',
    title: 'Team meeting',
    description: 'Discuss project updates and next steps with the team.',
    isCompleted: true,
    dueDate: DateTime.now().subtract(Duration(days: 1)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user2',
    title: 'Submit assignment',
    description: 'Finalize and submit the database assignment.',
    isCompleted: false,
    dueDate: DateTime.now().add(Duration(days: 4)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user2',
    title: 'Grocery shopping',
    description: 'Buy essentials: milk, eggs, and bread.',
    isCompleted: true,
    dueDate: DateTime.now().subtract(Duration(hours: 5)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user3',
    title: 'Read Flutter documentation',
    description: 'Focus on state management and provider pattern.',
    isCompleted: false,
    dueDate: DateTime.now().add(Duration(days: 3)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user3',
    title: 'Exercise',
    description: 'Go for a 30-minute run in the evening.',
    isCompleted: false,
    dueDate: DateTime.now().add(Duration(hours: 8)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user4',
    title: 'Design logo',
    description: 'Create a professional logo for the client’s website.',
    isCompleted: false,
    dueDate: DateTime.now().add(Duration(days: 7)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user4',
    title: 'Fix production bug',
    description: 'Resolve the login issue in the production environment.',
    isCompleted: true,
    dueDate: DateTime.now().subtract(Duration(days: 2)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user5',
    title: 'Prepare presentation',
    description: 'Create slides for the upcoming tech conference.',
    isCompleted: false,
    dueDate: DateTime.now().add(Duration(days: 5)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user5',
    title: 'Update resume',
    description: 'Revamp the resume with recent projects and skills.',
    isCompleted: true,
    dueDate: DateTime.now().subtract(Duration(days: 3)),
  ),
  Task(
    id: uuid.v4(),
    userId: 'user5',
    title: 'Update Onuvia name and website ',
    description: 'Revamp the resume with recent projects and skills.',
    isCompleted: true,
    dueDate: DateTime.now().subtract(Duration(days: 3)),
  ),
];
