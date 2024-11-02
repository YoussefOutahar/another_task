import 'package:another_task/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<LoadTasks>((event, emit) {
      emit(TaskLoading());
      Future.delayed(const Duration(seconds: 1));
      emit(TaskLoaded(tasks));
    });

    on<AddTask>((event, emit) {
      final currentState = state;
      if (currentState is TaskLoaded) {
        emit(TaskLoaded([...currentState.tasks, event.task]));
      }
    });

    on<UpdateTask>((event, emit) {
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.map((task) {
          return task.id == event.task.id ? event.task : task;
        }).toList();
        emit(TaskLoaded(updatedTasks));
      }
    });

    on<DeleteTask>((event, emit) {
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.where((task) {
          return task.id != event.task.id;
        }).toList();
        emit(TaskLoaded(updatedTasks));
      }
    });
  }
}
