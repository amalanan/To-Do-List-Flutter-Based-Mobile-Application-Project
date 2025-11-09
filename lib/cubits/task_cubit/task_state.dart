import '../../../imports.dart';

class TaskState {
  //task state
  final List<TaskModel> pendingTasks;
  final List<TaskModel> completedTasks;
  final bool isLoading;
  final String? errorMessage;

  TaskState({
    //constructor
    this.pendingTasks = const [],
    this.completedTasks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TaskState copyWith({
    //copy the state
    List<TaskModel>? pendingTasks,
    List<TaskModel>? completedTasks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TaskState(
      //return the new state
      pendingTasks: pendingTasks ?? this.pendingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
