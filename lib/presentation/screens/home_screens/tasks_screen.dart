import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistgsg/imports.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //add a post frame callback to get the user data from the session service
      final user =
          await SessionService.getSavedUser(); //get the user data from the session service
      if (user == null) {
        Navigator.pushReplacementNamed(context, Routes.login);
        return; //if the user is not authenticated it will be navigated to the login screen
      }
      context.read<TaskCubit>().loadTasks(); //load the tasks from task cubit
    });
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
          );
        } //if the user is not authenticated it will be navigated to the login screen
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, Routes.home),
            //navigate to the home screen
            child: Icon(
              Icons.arrow_back_ios,
              size: 36,
              color: Colors.blueGrey.shade200,
            ),
          ),
          title: CustomAppbarTitle(title: 'Tasks'),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: const [LogoutIcon()], //logout icon
        ),
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blueGrey.shade800,
                ), //circular progress indicator
              );
            }
            return RefreshIndicator(
              //refresh indicator to refresh the tasks
              onRefresh:
                  () async =>
                      await context
                          .read<TaskCubit>()
                          .loadTasks(), //load the tasks from task cubit
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Pending Tasks',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...state.pendingTasks.map((task) {
                      //map the pending tasks to task items
                      return TaskItem(
                        taskModel: task,
                        onChanged:
                            (_) =>
                                context.read<TaskCubit>().toggleTaskCompletion(
                                  task,
                                ), //toggle the task completion
                        onDelete:
                            (_) => context.read<TaskCubit>().deleteTask(
                              task,
                            ), //delete the task
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    const Text(
                      'Completed Tasks',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...state.completedTasks.map((task) {
                      //map the completed tasks to task items
                      return TaskItem(
                        taskModel: task,
                        onChanged: null,
                        onDelete:
                            (_) => context.read<TaskCubit>().deleteTask(
                              task,
                            ), //delete the task
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
