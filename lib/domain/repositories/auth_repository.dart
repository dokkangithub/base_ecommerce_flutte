import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login(String email, String password);
  Future<Either<Failure, AuthResponse>> socialLogin(String provider, String token);
  Future<Either<Failure, AuthResponse>> logout();
  Future<Either<Failure, AuthResponse>> deleteAccount();
  Future<Either<Failure, AuthResponse>> signup(Map<String, dynamic> userData);
  Future<Either<Failure, AuthResponse>> resendCode(String email);
  Future<Either<Failure, AuthResponse>> confirmCode(String email, String code);
  Future<Either<Failure, AuthResponse>> forgetPassword(String email);
  Future<Either<Failure, AuthResponse>> confirmResetPassword(String email, String code, String password);
  Future<Either<Failure, AuthResponse>> resendPasswordCode(String email);
  Future<Either<Failure, User>> getUserByToken(String token);
}