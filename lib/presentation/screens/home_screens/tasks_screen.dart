import 'package:todolistgsg/imports.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> inCompletedTasks = [];
  List<TaskModel> completedTasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    setState(() => isLoading = true);
    try {
      final tasks = await TaskService().getTasks();
      setState(() {
        completedTasks = tasks.where((t) => t.taskCompleted).toList();
        inCompletedTasks = tasks.where((t) => !t.taskCompleted).toList();
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void toggleTaskCompletion(int index, bool isCompleted) async {
    TaskModel task = isCompleted ? completedTasks[index] : inCompletedTasks[index];
    task.taskCompleted = !task.taskCompleted;

    await TaskService().updateTask(task);

    setState(() {
      if (task.taskCompleted) {
        completedTasks.add(task);
        inCompletedTasks.remove(task);
      } else {
        inCompletedTasks.add(task);
        completedTasks.remove(task);
      }
    });
  }

  void deleteTask(int index, bool isCompleted) async {
    TaskModel task = isCompleted ? completedTasks[index] : inCompletedTasks[index];
    await TaskService().deleteTask(task.id!);

    setState(() {
      if (isCompleted) completedTasks.removeAt(index);
      else inCompletedTasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: CustomAppbarTitle(title: 'Tasks'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: const [LogoutIcon()],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.blueGrey.shade800, // متناسق مع الواجهة
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Pending Tasks',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            ...inCompletedTasks.asMap().entries.map((entry) {
              int idx = entry.key;
              TaskModel task = entry.value;
              return TaskItem(
                taskModel: task,
                onChanged: (_) => toggleTaskCompletion(idx, false),
                onDelete: (ctx) => deleteTask(idx, false),
              );
            }).toList(),
            const SizedBox(height: 20),
            const Text(
              'Completed Tasks',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            ...completedTasks.asMap().entries.map((entry) {
              int idx = entry.key;
              TaskModel task = entry.value;
              return TaskItem(
                taskModel: task,
                onChanged: (_) => toggleTaskCompletion(idx, true),
                onDelete: (ctx) => deleteTask(idx, true),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
