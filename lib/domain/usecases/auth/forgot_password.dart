import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class ForgotPassword implements UseCase<AuthResponse, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPassword(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(ForgotPasswordParams params) async {
    return await repository.forgetPassword(params.email);
  }
}

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}