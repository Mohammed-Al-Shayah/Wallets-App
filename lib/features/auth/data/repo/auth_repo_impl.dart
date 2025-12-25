import 'package:wallets/core/networking/api_constants.dart';
import 'package:wallets/core/networking/api_service.dart';
import 'package:wallets/core/storage/token_storage.dart';
import 'package:wallets/core/storage/user_storage.dart';
import 'package:wallets/features/auth/data/models/user_data.dart';
import 'package:wallets/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService api;
  final TokenStorage tokenStorage;
  final UserStorage userStorage;

  AuthRepoImpl(
    this.userStorage, {
    required this.api,
    required this.tokenStorage,
  });

  @override
  Future<void> login({required String phone, required String password}) async {
    final res = await api.post(
      '${ApiConstants.baseApiUrl}/api/v1/auth/login',
      data: {'phone': phone, 'password': password},
    );

    final token = res['token'] ?? res['data']?['token'];
    if (token is String && token.isNotEmpty) {
      await tokenStorage.saveToken(token);
    }

    final userMap = _extractUser(res);
    if (userMap != null) {
      await userStorage.saveUser(User.fromJson(userMap));
    }
  }

  @override
  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String email,
  }) async {
    final res = await api.post(
      '${ApiConstants.baseApiUrl}/api/v1/auth/register',
      data: {
        'name': name,
        'phone': phone,
        'password': password,
        'email': email,
      },
    );

    // Some register flows only send an OTP without returning a token.
    final token = res['token'] ?? res['data']?['token'];
    if (token is String && token.isNotEmpty) {
      await tokenStorage.saveToken(token);
    }

    final userMap = _extractUser(res);
    if (userMap != null) {
      await userStorage.saveUser(User.fromJson(userMap));
    }
  }

  @override
  Future<void> otp({
    required String phone,
    required String code,
    required String purpose,
  }) async {
    final res = await api.post(
      '${ApiConstants.baseApiUrl}/api/v1/auth/verify-otp',
      data: {'phone': phone, 'code': code, 'purpose': purpose},
    );

    final userMap = _extractUser(res);
    if (userMap != null) {
      await userStorage.saveUser(User.fromJson(userMap));
    }

    final token = res['token'] ?? res['data']?['token'];
    if (token is String && token.isNotEmpty) {
      await tokenStorage.saveToken(token);
    }
  }

  Map<String, dynamic>? _extractUser(dynamic response) {
    if (response is! Map<String, dynamic>) return null;

    final candidates = <dynamic>[
      response['user'],
      response['data'],
      (response['data'] is Map<String, dynamic>)
          ? (response['data'] as Map<String, dynamic>)['user']
          : null,
    ];

    for (final c in candidates) {
      if (c is Map<String, dynamic>) return c;
    }
    return null;
  }
}
