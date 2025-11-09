import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../imports.dart';

class CreateEditScreen extends StatefulWidget {
  const CreateEditScreen({super.key});

  @override
  State<CreateEditScreen> createState() => _CreateEditScreenState();
}

class _CreateEditScreenState extends State<CreateEditScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super
        .initState(); //add a post frame callback to get the user data from the session service
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user =
          await SessionService.getSavedUser(); //get the user data from the session service
      if (user == null) {
        Navigator.pushReplacementNamed(context, Routes.login);
        return; //if the user is not authenticated it will be navigated to the login screen
      }
      context.read<TaskCubit>().loadTasks(); //load the tasks from task cubit
    });
  }

  Future<void> _addTask() async {
    final user =
        await SessionService.getSavedUser(); //get the user data from the session service
    if (user == null || _taskController.text.isEmpty) return;

    final newTask = TaskModel(
      taskName: _taskController.text,
      userId: user.id,
    ); //create a new task model

    _taskController.clear();
    context.read<TaskCubit>().addTask(
      newTask.taskName,
    ); //add the task to the task cubit
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      //listener to listen to the auth cubit specialized for the logout
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          ); //if the user is not authenticated it will be navigated to the login screen
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
          title: CustomAppbarTitle(title: 'Tasks'),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: const [LogoutIcon()], //logout icon
        ),
        body: BlocBuilder<TaskCubit, TaskState>(
          //builder to build the UI based on the state of the tasks
          builder: (context, state) {
            if (state.isLoading) {
              //if the tasks are loading it will show a circular progress indicator
              return Center(
                child: CircularProgressIndicator(
                  //circular progress indicator
                  color: Colors.blueGrey.shade900,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                //list view builder to build the tasks
                itemCount: state.pendingTasks.length,
                itemBuilder: (context, index) {
                  final task =
                      state.pendingTasks[index]; //get the task from the state
                  return TaskItem(
                    taskModel: task,
                    onChanged:
                        (_) => context.read<TaskCubit>().toggleTaskCompletion(
                          task,
                        ),
                    //toggle the task completion
                    onDelete: (_) => context.read<TaskCubit>().deleteTask(task),
                    //delete the task
                    onTap: () {
                      showEditTaskDialog(context, task, () {
                        context.read<TaskCubit>().editTask(
                          task,
                          task.taskName,
                        ); //edit the task
                      }); //show the edit task dialog
                    },
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  left: 30,
                  top: 5,
                  bottom: 5,
                ),
                child: AddNewTaskTextField(
                  taskController: _taskController,
                ), //add new task text field
              ),
            ),
            FloatingActionButton(
              onPressed: _addTask,
              backgroundColor: Colors.blueGrey.shade900,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
