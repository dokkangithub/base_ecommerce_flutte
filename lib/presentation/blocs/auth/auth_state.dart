import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthResponse response;

  const AuthSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UserLoadSuccess extends AuthState {
  final User user;

  const UserLoadSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutSuccess extends AuthState {}

class DeleteAccountSuccess extends AuthState {}

class SignupSuccess extends AuthState {
  final AuthResponse response;

  const SignupSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CodeSentSuccess extends AuthState {
  final String message;

  const CodeSentSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CodeConfirmedSuccess extends AuthState {
  final AuthResponse response;

  const CodeConfirmedSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class PasswordResetRequestSuccess extends AuthState {
  final String message;

  const PasswordResetRequestSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordResetSuccess extends AuthState {
  final String message;

  const PasswordResetSuccess(this.message);

  @override
  List<Object?> get props => [message];
}