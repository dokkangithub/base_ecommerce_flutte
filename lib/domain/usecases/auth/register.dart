import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';


class Register implements UseCase<AuthResponse, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(RegisterParams params) async {
    return await repository.signup(params.userData);
  }
}

class RegisterParams extends Equatable {
  final Map<String, dynamic> userData;

  const RegisterParams({
    required this.userData,
  });

  @override
  List<Object> get props => [userData];
}