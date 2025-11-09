import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'imports.dart';

void main() async {
  // making sure that the flutter engine is ready before running the application
  // it's very important for the SharedPreferences , DataBase  and for any async processes before running the app runApp
  WidgetsFlutterBinding.ensureInitialized();
  await TasksSqliteDb.init(); // initializing the database
  await printAllUsersAndTasks(); // printing all users and tasks
  //await clearAllDataOnce();  // clearing all the app data
  runApp(MyApp()); //running the app
}

// print all users and their tasks
Future<void> printAllUsersAndTasks() async {
  final users = await TasksSqliteDb.getUsers();
  print(
    'All Users',
  ); //printing all users saved in the shared preferences (session service)
  for (var user in users) {
    print(
      'User ID: ${user.id}, Name: ${user.firstName} ${user.lastName}, Email: ${user.email}',
    );
  }
  print('All Tasks'); //printing all tasks saved in the database (sqlite)
  for (var user in users) {
    final tasks = await TasksSqliteDb.getTasksForUser(user.id);
    print('tasks of  User ${user.id}:');
    for (var task in tasks) {
      print(
        'Task ID: ${task.id}, Name: ${task.taskName}, Completed: ${task.taskCompleted}',
      );
    }
  }
}

Future<void> clearAllDataOnce() async {
  // deleting the Database(SQlite) by clearing the tables (tasks & users)
  await TasksSqliteDb.clearAllTables();

  //deleting the Shared Preferences (Session Service) (saved users)
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  print('All Data  has been deleted');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // for the cubit state management
      // (calling the cubits and putting them above the main app)
      providers: [
        // auth cubit for login, signup, logouts functionalities
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()..tryAutoLogin()),
        //tasks cubit  for tasks management functionalities
        BlocProvider<TaskCubit>(create: (_) => TaskCubit()),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        //bloc builder for the authentication cubit
        // to be above the main app cuz it's the first thing called when running the app
        builder: (context, authState) {
          //builder cuz we want to build a UI each time( it requires changing in the UI)
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
            //theme of the app (font family)
            initialRoute: Routes.splash,
            //initial route of the app
            routes: {
              //routes of the app
              Routes.splash: (_) => const SplashPage(),
              Routes.login: (_) => const LoginScreen(),
              Routes.signup: (_) => SignUp(),
              Routes.home: (_) => MainNavigationScreen(),
              Routes.tasks: (_) => TasksScreen(),
              Routes.profile: (_) => ProfileScreen(),
              Routes.createEdit: (_) => CreateEditScreen(),
              Routes.dashboard: (_) => DashboardScreen(),
            },
          );
        },
      ),
    );
  }
}
