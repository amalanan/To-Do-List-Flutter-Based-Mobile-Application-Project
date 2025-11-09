import '../../data/models/user_model.dart';

abstract class AuthState {} // the state of the auth cubit

class AuthInitial extends AuthState {} // the initial state of the auth cubit

class AuthLoading extends AuthState {} // the loading state of the auth cubit

class AuthAuthenticated extends AuthState {
  // the authenticated state of the auth cubit
  final UserModel user; // the user model
  AuthAuthenticated(this.user); // constructor
} //

class AuthUnauthenticated
    extends AuthState {} // the unauthenticated state of the auth cubit

class AuthError extends AuthState {
  // the error state of the auth cubit
  final String message; // the error message
  AuthError(this.message); // constructor
}
