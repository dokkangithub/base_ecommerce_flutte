import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SocialLoginEvent extends AuthEvent {
  final String provider;
  final String token;

  const SocialLoginEvent({
    required this.provider,
    required this.token,
  });

  @override
  List<Object> get props => [provider, token];
}

class LogoutEvent extends AuthEvent {}

class DeleteAccountEvent extends AuthEvent {}

class SignupEvent extends AuthEvent {
  final Map<String, dynamic> userData;

  const SignupEvent({required this.userData});

  @override
  List<Object> get props => [userData];
}

class ResendCodeEvent extends AuthEvent {
  final String email;

  const ResendCodeEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ConfirmCodeEvent extends AuthEvent {
  final String email;
  final String code;

  const ConfirmCodeEvent({
    required this.email,
    required this.code,
  });

  @override
  List<Object> get props => [email, code];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String code;
  final String password;

  const ResetPasswordEvent({
    required this.email,
    required this.code,
    required this.password,
  });

  @override
  List<Object> get props => [email, code, password];
}

class ResendPasswordCodeEvent extends AuthEvent {
  final String email;

  const ResendPasswordCodeEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class GetUserByTokenEvent extends AuthEvent {
  final String token;

  const GetUserByTokenEvent({required this.token});

  @override
  List<Object> get props => [token];
}