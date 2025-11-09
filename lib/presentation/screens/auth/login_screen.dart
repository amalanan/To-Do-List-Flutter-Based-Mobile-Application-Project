import '../../../imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController =
      TextEditingController(); //text field controller for the username
  final TextEditingController passController =
      TextEditingController(); //text field controller for the password
  final _formKey = GlobalKey<FormState>(); //form of the screen for the
  // validation of the whole screen

  @override
  void dispose() {
    userNameController
        .dispose(); //disposing the username controller to avoid memory leaks
    passController
        .dispose(); // disposing the password controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // main screen
      backgroundColor: Colors.blueGrey.shade200,
      //background color of the screen
      appBar: AppBar(
        //appBar (login)
        title: CustomAppbarTitle(title: 'Login'),
        // custom widget for the app bar title and its style
        centerTitle: true,
        backgroundColor: Colors.black, //background color of the appbar
      ),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          // bloc consumer (builder and listener to listen to the state of the user and to build an UI based on it )
          listener: (context, state) {
            //if the state of the user
            // is AuthAuthenticated it means that the user is logged in successfully so will be delayed for 2 seconds
            // until the animation is gone then the context will be navigated to home Screen (it contains
            // the bottom navigation bar (main navigation screen))
            // we're not forgetting to pass the User as an argument to home screen
            // which passes it to the main navigation screens
            if (state is AuthAuthenticated) {
              Navigator.pushReplacementNamed(
                context,
                Routes.home,
                arguments: state.user,
              );
              // if the user state is causing an Error state a snack bar will be showed on screen with the error message
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  // the content of the snack bar message
                  backgroundColor: Colors.black,
                ),
              );
            }
          }, // building the UI based on the state of the user
          builder: (context, state) {
            bool
            isLoading = // gets the true boolean value of the Authloading state ,, if it's false it will
                // show the circular progress indicator
                state
                    is AuthLoading; // state is AuthLoading while the user is logging in
            return Center(
              child: Form(
                // the form which contains all the validations
                // of the text fields to get the validation of the screen by the form key
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  //making the column scrollable
                  child: Column(
                    // the screen UI
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        //app logo
                        radius: 80,
                        child: Image.asset(
                          'assets/images/logo1.jpg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomTextField(
                        //user name custom text field based on the form text field
                        hint: 'Username',
                        // hint text
                        fieldController: userNameController,
                        // the text field controller
                        validate: // validation of the form text field
                            (username) =>
                                username!
                                        .isNotEmpty // can't be empty (true validation)
                                    ? null
                                    : 'Enter Valid username', //error message for the false validation (null or empty username)
                      ),
                      CustomTextField(
                        //password custom text field based on the form text field
                        hint: 'Password',
                        // hint text
                        isPassword: true,
                        // password field for the obscure text field
                        fieldController: passController,
                        // password controller
                        validate: // validation of the form text field
                            (
                              password,
                            ) => // can't be less than 4 letters (true validation)
                                password!.length >= 4
                                    ? null
                                    : 'Weak Password', // false validation error message
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        // the sign up screen navigation button
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.signup,
                          );
                        },
                        child: const Text(
                          'Didn\'t have an account?', // Sign up button text
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        // login custom text button
                        onPressed:
                            isLoading
                                ? () {} // circular progress indicator
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    // if the validation of the whole screen which
                                    // depends on the validation of the form key is true it means we will read the
                                    // auth cubit login method of teh auth cubit and
                                    // passing the texts of the two text fields to the next screen as user model arguments
                                    context.read<AuthCubit>().login(
                                      userNameController.text.trim(),
                                      passController.text.trim(),
                                    );
                                  }
                                },
                        title:
                            isLoading // if its is true it shows the indicator  (the build of the UI (changing the ui thats the reason we used bloc consumer))
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text(
                                  // if it is false it will show the login text as the title of the text button (custom button widget)
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
