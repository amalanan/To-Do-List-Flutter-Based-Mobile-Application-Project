import '../../../imports.dart';

class CreateEditScreen extends StatefulWidget {
  const CreateEditScreen({super.key});

  @override
  State<CreateEditScreen> createState() => _CreateEditScreenState();
}

class _CreateEditScreenState extends State<CreateEditScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TaskService taskService = TaskService();
  List<TaskModel> pendingTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPendingTasks();
  }

  Future<void> _loadPendingTasks() async {
    setState(() => isLoading = true);
    try {
      pendingTasks = await taskService.fetchPendingTasks();
    } catch (e) {
      print('Error loading tasks: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // إضافة مهمة جديدة
  Future<void> _addTask() async {
    if (_taskController.text.isEmpty) return;
    setState(() => isLoading = true);
    try {
      final newTask = TaskModel(taskName: _taskController.text, taskCompleted: false);
      await taskService.addTask(newTask);
      await _loadPendingTasks(); // تحديث القائمة بعد الإضافة
      _taskController.clear();
    } catch (e) {
      print('Failed to add task: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // حذف مهمة
  Future<void> _deleteTask(TaskModel task) async {
    setState(() => isLoading = true);
    try {
      await taskService.deleteTask(task.id!);
      await _loadPendingTasks();
    } catch (e) {
      print('Failed to delete task: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // تغيير حالة المهمة (مكتملة/معلقة)
  Future<void> _toggleTaskCompletion(TaskModel task) async {
    setState(() => isLoading = true);
    try {
      task.taskCompleted = !task.taskCompleted;
      await taskService.updateTask(task);
      await _loadPendingTasks();
    } catch (e) {
      print('Failed to update task: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // تعديل اسم المهمة
  void _editTaskDialog(TaskModel task) {
    final editController = TextEditingController(text: task.taskName);
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.blueGrey.shade800, // نفس لون الـ TaskItem
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Task',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: Colors.blueGrey.shade400,
                decoration: InputDecoration(
                  hintText: 'Task Name',
                  hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                  filled: true,
                  fillColor: Colors.blueGrey.shade900,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blueGrey.shade100, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      task.taskName = editController.text;
                      await taskService.updateTask(task);
                      Navigator.pop(context);
                      await _loadPendingTasks();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: CustomAppbarTitle(title: 'Tasks'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: const [LogoutIcon()],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.blueGrey.shade900,
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemCount: pendingTasks.length,
          itemBuilder: (context, index) {
            final task = pendingTasks[index];
            return TaskItem(
              taskModel: task,
              onChanged: (_) => _toggleTaskCompletion(task),
              onDelete: (_) => _deleteTask(task),
              onTap: () => _editTaskDialog(task),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 30, top: 5, bottom: 5),
              child: TextField(
                controller: _taskController,
                style: const TextStyle(fontSize: 15, color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Add a new Task',
                  hintStyle: const TextStyle(fontSize: 15, color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade200),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade200),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: _addTask,
            backgroundColor: Colors.blueGrey.shade900,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}