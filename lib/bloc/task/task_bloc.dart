import 'package:another_task/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
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
    const Task(
      id: '3',
      title: 'Look for a job',
      category: 'Daily',
    ),
    const Task(
      id: '4',
      title: 'Check invitation maker',
      category: 'Daily',
    ),
    const Task(
      id: '5',
      title: 'Watch life of pie',
      category: 'Daily',
    ),
    const Task(
      id: '6',
      title: 'Look for a job',
      category: 'Daily',
    ),
  ];

  TaskBloc() : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoading());
      Future.delayed(const Duration(seconds: 5));
      emit(TaskLoaded(tasks));
    } catch (e) {
      // You might want to create and emit an error state here
      emit(TaskInitial());
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      final currentState = state;
      if (currentState is TaskLoaded) {
        emit(TaskLoaded([...currentState.tasks, event.task]));
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    try {
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.map((task) {
          return task.id == event.task.id ? event.task : task;
        }).toList();
        emit(TaskLoaded(updatedTasks));
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.where((task) {
          return task.id != event.task.id;
        }).toList();
        emit(TaskLoaded(updatedTasks));
      }
    } catch (e) {
      // Handle error
    }
  }
}
