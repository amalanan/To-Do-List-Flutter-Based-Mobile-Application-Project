import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../imports.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //text field controller for the user data saving them inside the user model session service
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //form of the screen for the
  // validation of the whole screen
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController
        .dispose(); //disposing the username controller to avoid memory leaks
    passwordController
        .dispose(); // disposing the password controller to avoid memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // main screen
      backgroundColor: Colors.blueGrey.shade200,
      //background color of the screen
      //appBar (signup)
      appBar: AppBar(
        // custom widget for the app bar title and its style
        title: CustomAppbarTitle(title: 'Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.black, //background color of the appbar
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // bloc consumer (builder and listener to listen to the state of the user and to build an UI based on it )
          if (state is AuthAuthenticated) {
            //if the state of the user
            // is AuthAuthenticated it means that the user is signed up successfully so will be delayed for 2 seconds
            // until the animation is gone then the context will be navigated to home Screen (it contains
            // the bottom navigation bar (main navigation screen))
            // we're not forgetting to pass the User as an argument to home screen
            // which passes it to the main navigation screens
            Navigator.pushReplacementNamed(
              context,
              Routes.home,
              arguments: state.user,
            );
          } else if (state is AuthError) {
            // if the user state is causing an Error state a snack bar will be showed on screen with the error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                // the content of the snack bar message
                backgroundColor: Colors.black,
              ),
            );
            // here we wondering of the snack bar error message contains the word exits it
            // means it is an already logged in user so he can't sign up and create an account again!
            // he needs to go to the login screen
            if (state.message.contains('exists')) {
              Navigator.pushReplacementNamed(context, Routes.login);
            }
          }
        },
        builder: (context, state) {
          // building the UI based on the state of the user
          final isLoading =
              state
                  is AuthLoading; // gets the true boolean value of the Authloading state ,, if it's false it will
          // show the circular progress indicator
          // state is AuthLoading while the user is signing up
          return Center(
            // sign up screen ui
            child: Form(
              // the form which contains all the validations
              // of the text fields to get the validation of the screen by the form key
              key: _formKey,
              child: SingleChildScrollView(
                //making the column scrollable
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    CircleAvatar(
                      // app logo
                      radius: 80,
                      child: Image.asset(
                        'assets/images/logo1.jpg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      // user name custom text field based on the form text field
                      hint: 'Username',
                      // hint text
                      fieldController: userNameController,
                      // the text field controller
                      validate:
                          (name) =>
                              name!.length >= 3
                                  ? null
                                  : 'Enter valid username', // validation of the form text field
                    ),
                    CustomTextField(
                      // email custom text field based on the form text field
                      hint: 'Email', //hint text
                      fieldController: emailController,
                      validate: (email) {
                        if (!email!.contains('@')) {
                          return 'Email must contain @'; // email must contain the @ sign & .
                        }
                        if (!email.contains('.')) {
                          return 'Email must contain .'; // validation of the form text field
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      // password custom text field based on the form text field
                      hint: 'Password',
                      isPassword: true,
                      // password field for the obscure text field
                      fieldController: passwordController,
                      validate: (password) {
                        if (password!.length >= 8)
                          return null; // can't be less than 8 letters (true validation)
                        return 'Weak password'; // false validation error message
                      },
                    ),
                    CustomTextField(
                      hint: 'Confirm Password',
                      isPassword: true,
                      fieldController: confirmPasswordController,
                      validate: (confirmPassword) {
                        if (confirmPassword == passwordController.text &&
                            confirmPassword!.isNotEmpty) {
                          // if the password and the confirm password are the same
                          return null; // can't be empty (true validation)
                        }
                        return 'Passwords must match';
                      },
                    ),
                    CustomTextField(
                      // first name custom text field based on the form text field
                      hint: 'First Name',
                      fieldController: firstNameController,
                      validate:
                          (name) =>
                              name!.length >= 3
                                  ? null
                                  : 'Enter valid name', // validation of the form text field
                    ),
                    CustomTextField(
                      // last name custom text field based on the form text field
                      hint: 'Last Name',
                      fieldController: lastNameController,
                      validate:
                          (name) =>
                              name!.length >= 3
                                  ? null
                                  : 'Enter valid name', // validation of the form text field
                    ),
                    CustomTextField(
                      hint: 'Gender (Male/Female)',
                      fieldController: genderController,
                      validate: (gender) {
                        if (gender == null || gender.isEmpty) {
                          return 'Enter Gender';
                        } // can't be empty (true validation)
                        final g = gender.toLowerCase();
                        if (g != 'male' && g != 'female') {
                          return 'Gender must be Male or Female'; // validation of the form text field
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                      child: const Text(
                        'Already have an account?',
                        // Sign up button text (login screen navigation button)
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    CustomButton(
                      // sign up custom text button
                      onPressed:
                          isLoading
                              ? () {} // circular progress indicator
                              : () {
                                if (_formKey.currentState!.validate()) {
                                  final newUser = UserModel(
                                    id: DateTime.now().millisecondsSinceEpoch,
                                    username: userNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    gender:
                                        genderController.text.trim().isEmpty
                                            ? 'Not specified'
                                            : genderController.text.trim(),
                                    image: '',
                                  );
                                  context.read<AuthCubit>().signup(
                                    newUser,
                                  ); // passing the user data to the auth cubit signup method
                                }
                              },
                      title: // if its is true it shows the indicator  (the build of the UI (changing the ui that's the reason we used bloc consumer))
                          isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
