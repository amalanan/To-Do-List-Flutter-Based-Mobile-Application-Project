// ignore: must_be_immutable
import '../../../imports.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: CustomAppbarTitle(title: 'SignUp'),
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
                  hint: 'Name',
                  fieldController: nameController,
                  validate: (name) {
                    return name!.length >= 3 ? null : 'Enter Valid Name';
                  },
                ),
                CustomTextField(
                  hint: 'Email',
                  fieldController: emailCont,
                  validate: (email) {
                    if (!email!.contains('@')) return 'Email must contain @';
                    if (!email.contains('.')) return 'Email must contain .';
                    return null;
                  },
                ),
                CustomTextField(
                  hint: 'password',
                  isPassword: true,
                  fieldController: passwordCont,
                  validate: (password) {
                    if (password!.length >= 8) return null;
                    return 'Weak Password';
                  },
                ),
                CustomTextField(
                  hint: 'confirm password',
                  isPassword: true,
                  fieldController: confirmPasswordCont,
                  validate: (confirmPassword) {
                    if (confirmPassword == passwordCont.text &&
                        confirmPassword!.isNotEmpty) {
                      return null;
                    }
                    return 'Password must match';
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  },
                  child: Text(
                    'Already have an account??',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                CustomButton(
                  onPressed: () => _signup(context),
                  title:
                      isLoading
                          ? CircularProgressIndicator()
                          : Text(
                            'SignUp',
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

  _signup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(
        context,
        Routes.home,
        arguments: nameController.text,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enter Valid Credentials',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.black,
        ),
      );
    }
  }
}
