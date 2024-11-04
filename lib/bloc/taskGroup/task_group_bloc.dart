import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/task_group.dart';

part 'task_group_event.dart';
part 'task_group_state.dart';

class TaskGroupBloc extends Bloc<TaskGroupEvent, TaskGroupState> {
  List<TaskGroup> _taskGroups = [
    const TaskGroup(
      id: '1',
      title: 'Personal',
      taskIds: ['1', '2', '3'],
    ),
    const TaskGroup(
      id: '2',
      title: 'Work',
      taskIds: ['4', '5'],
    ),
    const TaskGroup(
      id: '3',
      title: 'Meeting',
      taskIds: ['6'],
    ),
  ];

  TaskGroupBloc() : super(TaskGroupInitial()) {
    on<LoadTaskGroups>(_onLoadTaskGroups);
    on<AddTaskGroup>(_onAddTaskGroup);
    on<UpdateTaskGroup>(_onUpdateTaskGroup);
    on<DeleteTaskGroup>(_onDeleteTaskGroup);
  }

  Future<void> _onLoadTaskGroups(
    LoadTaskGroups event,
    Emitter<TaskGroupState> emit,
  ) async {
    try {
      emit(TaskGroupLoading());
      // Here you would typically load task groups from a repository or database
      // For now, we'll just emit the current list
      emit(TaskGroupsLoaded(_taskGroups));
    } catch (e) {
      // You might want to create and emit an error state here
      emit(TaskGroupInitial());
    }
  }

  Future<void> _onAddTaskGroup(
    AddTaskGroup event,
    Emitter<TaskGroupState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is TaskGroupsLoaded) {
        _taskGroups = List.from(currentState.taskGroups)..add(event.taskGroup);
        emit(TaskGroupsLoaded(_taskGroups));
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onUpdateTaskGroup(
    UpdateTaskGroup event,
    Emitter<TaskGroupState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is TaskGroupsLoaded) {
        _taskGroups = currentState.taskGroups.map((taskGroup) {
          return taskGroup.id == event.taskGroup.id ? event.taskGroup : taskGroup;
        }).toList();
        emit(TaskGroupsLoaded(_taskGroups));
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onDeleteTaskGroup(
    DeleteTaskGroup event,
    Emitter<TaskGroupState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is TaskGroupsLoaded) {
        _taskGroups = currentState.taskGroups.where((taskGroup) => taskGroup.id != event.taskGroup.id).toList();
        emit(TaskGroupsLoaded(_taskGroups));
      }
    } catch (e) {
      // Handle error
    }
  }
}
