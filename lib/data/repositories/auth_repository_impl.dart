import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/laravel/auth_remote_datasource.dart';
import '../models/laravel/auth_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthResponse>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(email, password);
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> socialLogin(String provider, String token) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.socialLogin(provider, token);
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.logout();
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> deleteAccount() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.deleteAccount();
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signup(Map<String, dynamic> userData) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.signup(userData);
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> resendCode(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.resendCode(email);
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> confirmCode(String email, String code) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.confirmCode(email, code);
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> forgetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.forgetPassword(email);
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> confirmResetPassword(
      String email, String code, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.confirmResetPassword(email, code, password);
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> resendPasswordCode(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.resendPasswordCode(email);
        return Right(_mapAuthResponseModelToDomain(response));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserByToken(String token) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.getUserByToken(token);
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  // Helper method to map the model to domain entity
  AuthResponse _mapAuthResponseModelToDomain(AuthResponseModel model) {
    return AuthResponse(
      result: model.result,
      message: model.message,
      accessToken: model.accessToken,
      tokenType: model.tokenType,
      expiresAt: model.expiresAt,
      user: model.user,
    );
  }
}