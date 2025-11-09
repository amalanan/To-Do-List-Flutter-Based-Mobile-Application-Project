import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../imports.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    required this.taskModel,
    super.key,
    this.onChanged,
    this.onDelete,
    this.onTap,
  });

  final TaskModel taskModel;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.blueGrey.shade600,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskModel.taskCompleted,
                onChanged: onChanged,
                checkColor: Colors.blueGrey.shade400,
                activeColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Text(
                    taskModel.taskName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration:
                          taskModel.taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                      decorationColor: Colors.blueGrey.shade200,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
