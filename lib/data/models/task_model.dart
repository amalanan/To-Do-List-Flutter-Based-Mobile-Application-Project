class TaskModel {
  int? id;
  String taskName;
  bool taskCompleted;

  TaskModel({
    this.id,
    required this.taskName,
    this.taskCompleted = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json){
    return TaskModel(id: json['id'],
        taskName: json['todo'], taskCompleted: json['completed'] ?? false );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'todo': taskName,
    'completed' : taskCompleted
  };

Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': taskName,
    'completed': taskCompleted ? 1 : 0,
  };
}}
