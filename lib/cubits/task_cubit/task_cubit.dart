import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../imports.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskService _taskService = TaskService();

  TaskCubit() : super(TaskState());

  Future<void> loadTasks({int? userId}) async {
    //load the tasks from the task service
    emit(state.copyWith(isLoading: true, errorMessage: null)); //

    try {
      //try to load the tasks
      final UserModel? user =
          userId !=
                  null //check if the user id is not null
              ? await TasksSqliteDb.getUsers().then(
                (users) => //get the user from the database
                    users.firstWhere((u) => u.id == userId),
              ) //if the user id is not null
              : await SessionService.getSavedUser();

      if (user == null) throw Exception('User not authenticated');

      final tasks = await _taskService.fetchTasksForUser(
        user.id,
      ); //fetch the tasks for the user

      final pending =
          tasks.where((t) => !t.taskCompleted).toList(); //filter the tasks
      final completed = tasks.where((t) => t.taskCompleted).toList();

      emit(
        state.copyWith(
          //update the state
          pendingTasks: pending,
          completedTasks: completed,
          isLoading: false,
        ),
      ); //update the state
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: e.toString()),
      ); //catch any errors
    } //catch any errors
  } //load the tasks from the task service

  Future<void> addTask(String taskName) async {
    //add a new task
    if (taskName.isEmpty) return;
    emit(state.copyWith(isLoading: true, errorMessage: null));
    //update the state
    try {
      //try to add the task
      final user =
          await SessionService.getSavedUser(); //get the user from the session service
      if (user == null) throw Exception('User not authenticated');

      final newTask = TaskModel(taskName: taskName, userId: user.id);
      final addedTask = await _taskService.addTask(newTask);

      final updatedPending = List<TaskModel>.from(
        state.pendingTasks,
      ) //update the pending tasks
      ..add(addedTask);

      emit(
        state.copyWith(pendingTasks: updatedPending, isLoading: false),
      ); //update the state
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: e.toString()),
      ); //catch any errors
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    //delete a task
    emit(
      state.copyWith(isLoading: true, errorMessage: null),
    ); //update the state
    try {
      //try to delete the task
      await _taskService.deleteTask(task.id!);

      final updatedPending = List<TaskModel>.from(
        state.pendingTasks,
      ) //update the pending tasks
      ..removeWhere((t) => t.id == task.id);
      final updatedCompleted = List<TaskModel>.from(
        state.completedTasks,
      ) //update the completed tasks
      ..removeWhere((t) => t.id == task.id);

      emit(
        //update the state
        state.copyWith(
          //update the state
          pendingTasks: updatedPending,
          completedTasks: updatedCompleted,
          isLoading: false, //update the state
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: e.toString()),
      ); //catch any errors
    }
  }

  Future<void> toggleTaskCompletion(TaskModel task) async {
    //toggle the task completion
    emit(
      state.copyWith(isLoading: true, errorMessage: null),
    ); //update the state
    try {
      task.taskCompleted = !task.taskCompleted; //toggle the task completion
      await _taskService.updateTask(task);

      final updatedPending = List<TaskModel>.from(state.pendingTasks)
        ..removeWhere((t) => t.id == task.id); //update the pending tasks
      final updatedCompleted = List<TaskModel>.from(
        state.completedTasks,
      ) //update the completed tasks
      ..removeWhere((t) => t.id == task.id);

      if (task.taskCompleted) {
        updatedCompleted.add(task); //add the task to the completed tasks
      } else {
        updatedPending.add(task); //add the task to the pending tasks
      }

      emit(
        state.copyWith(
          //update the state
          pendingTasks: updatedPending,
          completedTasks: updatedCompleted,
          isLoading: false,
        ), //update the state
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: e.toString()),
      ); //catch any errors
    }
  }

  Future<void> editTask(TaskModel task, String newName) async {
    //edit a task
    emit(
      state.copyWith(isLoading: true, errorMessage: null),
    ); //update the state
    // try to edit the task
    try {
      task.taskName = newName;
      await _taskService.updateTask(task);
      //update the pending and completed tasks
      final updatedPending =
          state.pendingTasks.map((t) => t.id == task.id ? task : t).toList();
      //update the completed tasks
      final updatedCompleted =
          state.completedTasks.map((t) => t.id == task.id ? task : t).toList();
      //update the state
      emit(
        state.copyWith(
          pendingTasks: updatedPending,
          completedTasks: updatedCompleted,
          isLoading: false,
        ),
      );
    } catch (e) {
      //catch any errors
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
