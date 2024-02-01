abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoggedIn extends AuthState {
  final String token;

  AuthLoggedIn(this.token);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}