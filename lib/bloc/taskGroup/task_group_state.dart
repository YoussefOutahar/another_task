part of 'task_group_bloc.dart';

sealed class TaskGroupState extends Equatable {
  const TaskGroupState();

  @override
  List<Object> get props => [];
}

final class TaskGroupInitial extends TaskGroupState {}

final class TaskGroupLoading extends TaskGroupState {}

final class TaskGroupsLoaded extends TaskGroupState {
  final List<TaskGroup> taskGroups;

  const TaskGroupsLoaded(this.taskGroups);

  @override
  List<Object> get props => [taskGroups];
}
