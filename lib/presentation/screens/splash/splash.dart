import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../imports.dart';

class SplashPage extends StatefulWidget {
  //stateful widget cuz it uses an animation which is changing in the UI
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // animation Controller
  late Animation<double> _fadeAnimation; //type of animation (object)

  @override
  void initState() {
    super.initState(); //initializing the State of the Screen (build widget)

    //Starting the animation
    _controller = AnimationController(
      vsync: this, //controls the duration of the animation
      duration: const Duration(seconds: 2), //duration of the animation
    );
    //type of animation is fade animation which has double value from
    // start to end and controlled by the controller
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller); //controls the opacity of the animation
    _controller.forward(); //to start the animation with 2 seconds duration

    // delaying the login process by 2 seconds until the animation is gone
    Future.delayed(const Duration(seconds: 2), () {
      // connecting the screen by the auth cubit via
      // reading the context coming from the bloc listener on the build widget
      // calling the state of the user and based on it we will decide
      // which screen we will be navigated to [tryAutoLogin]
      context.read<AuthCubit>().tryAutoLogin();
    });
  }

  @override
  void dispose() {
    _controller.dispose(); //disposing the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //main screen
      backgroundColor: Colors.blueGrey.shade200,
      //background color of the screen
      body: BlocListener<AuthCubit, AuthState>(
        //bloc listener to listen to the auth cubit to decide which state is the user in
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            //if the state of the user
            // is AuthAuthenticated it means that the user is logged in so will be delayed for 2 seconds
            // until the animation is gone then the context will be navigated to home Screen (it contains
            // the bottom navigation bar (main navigation screen))
            // we're not forgetting to pass the User as an argument to home screen
            // which passes it to the main navigation screens
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushReplacementNamed(
                context,
                Routes.home,
                arguments: state.user,
              );
            });
          } else if (state is AuthUnauthenticated) {
            // if the user state is AuthUnauthenticated
            // then the animation will be gone and the user will be navigated to login screen
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushReplacementNamed(context, Routes.login);
            });
          }
        },
        child: Center(
          // the UI
          child: FadeTransition(
            // the fade transition which is the type of the animation we used inside this Splash
            opacity: _fadeAnimation, // the opacity of the animation
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  child: Image.asset(
                    //app logo
                    'assets/images/logo1.jpg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to ToDoList', //app name
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
