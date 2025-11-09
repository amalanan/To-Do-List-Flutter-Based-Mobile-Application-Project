import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistgsg/imports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String firstName = '';

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
      setState(
        () => firstName = user.firstName,
      ); //set the first name of the user
      context.read<TaskCubit>().loadTasks(); //load the tasks from task cubit
    });
  }

  Future<void> _onRefresh() async {
    await context
        .read<TaskCubit>()
        .loadTasks(); //load the tasks from task cubit
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
        backgroundColor: Colors.blueGrey.shade100,
        appBar: AppBar(
          title: CustomAppbarTitle(title: 'Home'),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: const [LogoutIcon()], //logout icon
        ),
        body: RefreshIndicator(
          //refresh indicator to refresh the tasks
          onRefresh: _onRefresh,
          child: BlocBuilder<TaskCubit, TaskState>(
            //builder to build the UI based on the state of the tasks
            builder: (context, state) {
              final pendingTasks =
                  state.pendingTasks.length > 3
                      ? state.pendingTasks.sublist(
                        state.pendingTasks.length - 3,
                      )
                      : state.pendingTasks;
              return DasboardScreenColumn(
                firstName: firstName,
                completedCount: state.completedTasks.length,
                // the count of the completed tasks
                pendingCount: state.pendingTasks.length,
                // the count of the pending tasks
                pendingTasks: pendingTasks,
              );
            },
          ),
        ),
      ),
    );
  }
}
