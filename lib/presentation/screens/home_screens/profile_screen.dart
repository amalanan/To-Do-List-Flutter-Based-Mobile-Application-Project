import 'package:todolistgsg/imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      //listener to listen to the auth cubit
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushReplacementNamed(
            context,
            Routes.login,
          ); //if the user is not authenticated it will be navigated to the login screen
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          //builder to build the UI based on the state of the user
          if (state is AuthLoading) {
            return ProfileScreenCircularProgressIndicator(); //while the user is loading it will show the circular progress indicator
          } else if (state is AuthAuthenticated) {
            //if the user is authenticated it will show the profile screen UI
            final user = state.user; //get the user data from the state
            final userModelData = [
              'User Name: ',
              'Email: ',
              'First Name: ',
              'Last Name: ',
              'Gender: ',
            ]; //list of user data to show in the profile screen
            final userData = [
              user.username,
              user.email,
              user.firstName,
              user.lastName,
              user.gender,
            ]; //list of user data to show in the profile screen

            return ProfileScreenUI(
              //the profile screen UI
              image: user.image,
              user: user,
              userData: userData,
              userModelData: userModelData,
            ); //passing the user data to the profile screen UI
          } else {
            return ProfileScreenCircularProgressIndicator(); //if the user is not authenticated it will show the circular progress indicator
          }
        },
      ),
    );
  }
}
