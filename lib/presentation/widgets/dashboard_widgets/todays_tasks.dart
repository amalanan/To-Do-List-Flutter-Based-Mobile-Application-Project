import 'package:todolistgsg/imports.dart';

class TodaysTasks extends StatelessWidget {
  const TodaysTasks({super.key, required this.pendingTasks});

  final List<TaskModel> pendingTasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        pendingTasks.isEmpty
            ? const Text(
              "No pending tasks for today (':",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
            : Column(
              children:
                  pendingTasks //map the pending tasks to task items
                      .map(
                        (task) => TaskItem(
                          taskModel: task,
                          onChanged:
                              (_) => Navigator.pushReplacementNamed(
                                context,
                                Routes.tasks,
                              ), //navigate to tasks screen
                        ),
                      )
                      .toList(), //convert the map to a list
            ),
      ],
    );
  }
}
