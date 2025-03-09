import 'dart:convert';
import '../../../core/api/laravel_api_provider.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/laravel/auth_response_model.dart';
import '../../models/laravel/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(String email, String password);
  Future<AuthResponseModel> socialLogin(String provider, String token);
  Future<AuthResponseModel> logout();
  Future<AuthResponseModel> deleteAccount();
  Future<AuthResponseModel> signup(Map<String, dynamic> userData);
  Future<AuthResponseModel> resendCode(String email);
  Future<AuthResponseModel> confirmCode(String email, String code);
  Future<AuthResponseModel> forgetPassword(String email);
  Future<AuthResponseModel> confirmResetPassword(String email, String code, String password);
  Future<AuthResponseModel> resendPasswordCode(String email);
  Future<UserModel> getUserByToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final LaravelApiProvider apiProvider;

  AuthRemoteDataSourceImpl({required this.apiProvider});

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final response = await apiProvider.post(
      'auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw const ServerException( 'Failed to login');
    }
  }

  @override
  Future<AuthResponseModel> socialLogin(String provider, String token) async {
    final response = await apiProvider.post(
      'auth/social-login',
      data: {
        'provider': provider,
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException( 'Failed to login with $provider');
    }
  }

  @override
  Future<AuthResponseModel> logout() async {
    final response = await apiProvider.post('auth/logout');

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw const ServerException( 'Failed to logout');
    }
  }

  @override
  Future<AuthResponseModel> deleteAccount() async {
    final response = await apiProvider.post('auth/account-deletion');

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw const ServerException( 'Failed to delete account');
    }
  }

  @override
  Future<AuthResponseModel> signup(Map<String, dynamic> userData) async {
    final response = await apiProvider.post(
      'auth/signup',
      data: userData,
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw const ServerException( 'Failed to sign up');
    }
  }

  @override
  Future<AuthResponseModel> resendCode(String email) async {
    final response = await apiProvider.post(
      'auth/resend_code',
      data: {'email': email},
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw const ServerException( 'Failed to resend verification code');
    }
  }

  @override
  Future<AuthResponseModel> confirmCode(String email, String code) async {
    final response = await apiProvider.post(
      'auth/confirm_code',
      data: {
        'email': email,
        'verification_code': code,
      },
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw const ServerException( 'Failed to confirm code');
    }
  }

  @override
  Future<AuthResponseModel> forgetPassword(String email) async {
    final response = await apiProvider.post(
      'auth/password/forget_request',
      data: {'email': email},
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw const ServerException( 'Failed to process forget password request');
    }
  }

  @override
  Future<AuthResponseModel> confirmResetPassword(String email, String code, String password) async {
    final response = await apiProvider.post(
      'auth/password/confirm_reset',
      data: {
        'email': email,
        'verification_code': code,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw const ServerException( 'Failed to reset password');
    }
  }

  @override
  Future<AuthResponseModel> resendPasswordCode(String email) async {
    final response = await apiProvider.post(
      'auth/password/resend_code',
      data: {'email': email},
    );

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException('Failed to resend password reset code');
    }
  }

  @override
  Future<UserModel> getUserByToken(String token) async {
    final response = await apiProvider.get(
      'get-user-by-access_token',
      //headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserModel.fromJson(jsonData['user']);
    } else {
      throw ServerException( 'Failed to get user by token');
    }
  }
}