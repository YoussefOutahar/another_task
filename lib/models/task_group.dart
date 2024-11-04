import 'package:equatable/equatable.dart';

class TaskGroup extends Equatable {
  final String id;
  final String title;
  final List<String> taskIds;

  const TaskGroup({
    required this.id,
    required this.title,
    this.taskIds = const [],
  });

  TaskGroup copyWith({
    String? id,
    String? title,
    List<String>? taskIds,
  }) {
    return TaskGroup(
      id: id ?? this.id,
      title: title ?? this.title,
      taskIds: taskIds ?? this.taskIds,
    );
  }

  @override
  List<Object?> get props => [id, title, taskIds];

  static TaskGroup fromJson(Map<String, dynamic> json) {
    return TaskGroup(
      id: json['id'],
      title: json['title'],
      taskIds: (json['taskIds'] as List).map((taskId) => taskId.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'taskIds': taskIds,
    };
  }
}
