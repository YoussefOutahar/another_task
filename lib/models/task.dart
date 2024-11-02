import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final String category;
  final DateTime? dueDate;
  final List<Task> subtasks;

  const Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.category,
    this.dueDate,
    this.subtasks = const [],
  });

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? category,
    DateTime? dueDate,
    List<Task>? subtasks,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      subtasks: subtasks ?? this.subtasks,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted, category, dueDate, subtasks];

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      category: json['category'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      subtasks: (json['subtasks'] as List).map((task) => Task.fromJson(task)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'category': category,
      'dueDate': dueDate?.toIso8601String(),
      'subtasks': subtasks.map((task) => task.toJson()).toList(),
    };
  }
}

List<Task> tasks = [
  const Task(
    id: '1',
    title: 'Check invitation maker',
    category: 'Daily',
  ),
  const Task(
    id: '2',
    title: 'Watch life of pie',
    category: 'Daily',
  ),
];
