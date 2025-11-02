import '../../../imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String userCredentialsKey = 'hasLoggedIn';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: CustomAppbarTitle(title: 'Login'),

        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  child: Image.asset(
                    'assets/images/logo1.jpg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(height: 40),
                CustomTextField(
                  hint: 'Email',
                  fieldController: emailController,
                  validate: (email) {
                    if (email!.contains('@') && email.contains('.')) {
                      return null;
                    }
                    return 'Enter Valid Email';
                  },
                ),
                CustomTextField(
                  hint: 'Password',
                  isPassword: true,
                  fieldController: passController,
                  validate: (password) {
                    if (password!.length >= 8) return null;
                    return 'Weak Password';
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.signup);
                  },
                  child: Text(
                    'Didn\'t have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                CustomButton(
                  onPressed: () => _login(context),
                  title:
                      isLoading
                          ? CircularProgressIndicator()
                          : Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
    if (_formKey.currentState!.validate()) {
      await loginUser(emailController.text);
      Navigator.pushReplacementNamed(
        // ignore: use_build_context_synchronously
        context,
        Routes.home,
        arguments: emailController.text,
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enter Valid Credentials'),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.black,
        ),
      );
    }
  }

  loginUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(LoginScreen.userCredentialsKey, email);
  }
}
