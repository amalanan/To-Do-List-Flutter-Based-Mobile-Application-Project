import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistgsg/imports.dart';

class AuthCubit extends Cubit<AuthState> {
  // auth cubit
  AuthCubit() : super(AuthInitial());

  Future<void> login(String username, String password) async {
    // login method
    emit(AuthLoading()); // emit loading state
    //
    try {
      // try to login
      UserModel? localUser = await TasksSqliteDb.getUserByUsername(
        username,
      ); // get user from db
      if (localUser != null) {
        await SessionService.saveUser(localUser); // save user to session
        emit(AuthAuthenticated(localUser)); // emit authenticated state
        return;
      }

      final user = await AuthService.loginWithUserName(
        // login with username
        userName: username,
        password: password,
      );

      await TasksSqliteDb.insertUser(user!); // insert user to db
      await SessionService.saveUser(user); // save user to session
      emit(AuthAuthenticated(user)); // emit authenticated state
    } catch (e) {
      emit(AuthError('User Not Found, Please Sign Up')); // emit error state
    }
  }

  Future<void> signup(UserModel newUser) async {
    // sign up method
    emit(AuthLoading()); // emit loading state
    try {
      // try to sign up
      // if the username already exists, emit error
      final existingUser = await TasksSqliteDb.getUserByUsername(
        newUser.username,
      ); // get user from db
      if (existingUser != null) {
        // if user exists
        emit(
          AuthError('Username already exists. Please login.'),
        ); // emit error state
        return;
      }

      await TasksSqliteDb.insertUser(newUser); // insert user to db
      await SessionService.saveUser(newUser); // save user to session

      emit(AuthAuthenticated(newUser)); // emit authenticated state
    } catch (e) {
      emit(AuthError('Application Error!')); // emit error state
    }
  }

  Future<void> logout() async {
    // logout method
    emit(AuthLoading()); // emit loading state
    await SessionService.clear(); // clear session
    emit(AuthUnauthenticated()); // emit unauthenticated state
  }

  Future<void> tryAutoLogin() async {
    // try auto login method
    emit(AuthLoading()); // emit loading state
    final user = await SessionService.getSavedUser(); // get user from session
    if (user != null) {
      // if user exists
      emit(AuthAuthenticated(user)); // emit authenticated state
    } else {
      emit(AuthUnauthenticated()); // emit unauthenticated state
    }
  }
}
