import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth/login.dart';
import '../../../domain/usecases/auth/register.dart';
// Import other use cases
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUseCase;
  final Register registerUseCase;
  // Add other use cases

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    // Add other use cases
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<LogoutEvent>(_onLogout);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<ResendCodeEvent>(_onResendCode);
    on<ConfirmCodeEvent>(_onConfirmCode);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
    on<ResendPasswordCodeEvent>(_onResendPasswordCode);
    on<GetUserByTokenEvent>(_onGetUserByToken);
    on<SocialLoginEvent>(_onSocialLogin);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final params = LoginParams(email: event.email, password: event.password);
    final result = await loginUseCase(params);

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (response) => emit(AuthSuccess(response)),
    );
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final params = RegisterParams(userData: event.userData);
    final result = await registerUseCase(params);

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (response) => emit(SignupSuccess(response)),
    );
  }

  // Implement other event handlers similarly
  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the logout use case
  }

  Future<void> _onDeleteAccount(DeleteAccountEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the delete account use case
  }

  Future<void> _onResendCode(ResendCodeEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the resend code use case
  }

  Future<void> _onConfirmCode(ConfirmCodeEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the confirm code use case
  }

  Future<void> _onForgotPassword(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the forgot password use case
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the reset password use case
  }

  Future<void> _onResendPasswordCode(ResendPasswordCodeEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the resend password code use case
  }

  Future<void> _onGetUserByToken(GetUserByTokenEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the get user by token use case
  }

  Future<void> _onSocialLogin(SocialLoginEvent event, Emitter<AuthState> emit) async {
    // Implement
    emit(AuthLoading());
    // Add implementation when you add the social login use case
  }
}