import 'dart:io';

import '/common_libraries.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthAuthenticated>(_onAuthAuthenticated);
    on<AuthUnauthenticated>(_onAuthUnauthenticated);
  }

  @override
  void onChange(Change<AuthState> change) {
    // print(change.currentState);
    // print(change.nextState);
    super.onChange(change);
  }

  Future<void> _onAuthAuthenticated(
    AuthAuthenticated event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthAuthenticateInProgress());
    try {
      //AuthUser authUser = await authRepository.login(event.auth);
      if (event.auth.email == "admin" && event.auth.password == "admin") {
        Future.delayed(const Duration(seconds: 2));
        AuthUser authUser = AuthUser(
          id: id,
          name: 'Admin',
          email: 'admin@infomatrixinc.com',
          roleName: 'Manager',
          token: 'token',
        );
        emit(AuthAuthenticateSuccess(authUser: authUser));
      } else {
        emit(const AuthAuthenticateFailure(message: "Invalid username or password."));
      }
    } on HttpException catch (e) {
      emit(AuthForgotPasswordEnable(callbackUrl: e.message));
    } catch (e) {
      emit(const AuthAuthenticateFailure(message: "Invalid username or password."));
    }
  }

  Future<void> _onAuthUnauthenticated(
    AuthUnauthenticated event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthUnauthenticateInProgress());
    try {
      await authRepository.logout();
      emit(AuthUnauthenticateSuccess(authUser: null, statusCode: event.statusCode ?? 200));
    } catch (e) {
      emit(AuthUnauthenticateFailure());
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
