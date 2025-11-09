class TaskModel {
  int? id;
  String taskName;
  bool taskCompleted;
  int userId;

  TaskModel({
    this.id,
    required this.taskName,
    this.taskCompleted = false,
    required this.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    //convert the json to a task model
    return TaskModel(
      id: json['id'],
      taskName: json['todo'] ?? json['title'],
      taskCompleted: json['completed'] ?? false,
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    //convert the task model to a json
    'id': id,
    'title': taskName,
    'completed': taskCompleted ? true : false,
    'userId': userId,
  };

  Map<String, dynamic> toMap() => toJson(); //convert the task model to a map
}
