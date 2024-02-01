// import 'package:bloc/bloc.dart';
// import 'package:finnoto_login/data/models/user_model.dart';
// import 'package:finnoto_login/data/repositories/authentication_repository.dart';
// import 'package:finnoto_login/presentation/blocs/auth/auth_event/auth_event.dart';
// import 'package:finnoto_login/presentation/blocs/auth/auth_state/auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthenticationRepository authenticationRepository;
//
//   AuthBloc(this.authenticationRepository) : super(AuthInitial()) {
//     // Register a handler for LoginEvent to manage login logic
//     on<LoginEvent>((event, emit) async {
//       try {
//         // Attempt to login using the repository
//         final UserModel? user =
//         await authenticationRepository.login(event.email, event.password);
//
//         // If login is successful, emit AuthLoggedIn state with the token
//         if (user != null) {
//           emit(AuthLoggedIn(user.token));
//         } else {
//           // If login fails, emit AuthError state with an appropriate message
//           emit(AuthError('Login failed. Please check your credentials.'));
//         }
//       } catch (error) {
//         // Catch any errors during login and emit AuthError state
//         emit(AuthError('An error occurred. Please try again.'));
//       }
//     });
//   }
//
//   @override
//   Stream<AuthState> mapEventToState(AuthEvent event) async* {
//     // Delegate event handling to the specific handlers for each event type
//     if (event is LoginEvent) {
//       yield* _mapLoginEventToState(event);
//     }
//     // Add handlers for other AuthEvents as needed
//   }
//
//   // Stream for handling LoginEvent (logic is now moved to the on<LoginEvent> handler)
//   Stream<AuthState> _mapLoginEventToState(LoginEvent event) async* {
//     print("LoginEvent received in AuthBloc");
//     yield AuthInitial();
//
//     try {
//       final UserModel? user = await authenticationRepository.login(event.email, event.password);
//
//       if (user != null) {
//         yield AuthLoggedIn(user.token);
//       } else {
//         yield AuthError('Login failed. Please check your credentials.');
//       }
//     } catch (error) {
//       print("Error in AuthBloc: $error");
//       yield AuthError('An error occurred. Please try again.');
//     }
//   }
// }
