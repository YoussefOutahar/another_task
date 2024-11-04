part of 'task_group_bloc.dart';

sealed class TaskGroupEvent extends Equatable {
  const TaskGroupEvent();

  @override
  List<Object> get props => [];
}

class LoadTaskGroups extends TaskGroupEvent {}

class AddTaskGroup extends TaskGroupEvent {
  final TaskGroup taskGroup;

  const AddTaskGroup(this.taskGroup);

  @override
  List<Object> get props => [taskGroup];
}

class UpdateTaskGroup extends TaskGroupEvent {
  final TaskGroup taskGroup;

  const UpdateTaskGroup(this.taskGroup);

  @override
  List<Object> get props => [taskGroup];
}

class DeleteTaskGroup extends TaskGroupEvent {
  final TaskGroup taskGroup;

  const DeleteTaskGroup(this.taskGroup);

  @override
  List<Object> get props => [taskGroup];
}
