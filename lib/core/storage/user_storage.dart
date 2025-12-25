import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallets/core/storage/storage_keys.dart';
import 'package:wallets/features/auth/data/models/user_data.dart';

class UserStorage {
  final SharedPreferences _preferences;
  const UserStorage(this._preferences);

  Future<void> saveUser(User user) async {
    final userJson = user.toJson()..remove('password');
    await _preferences.setString(StorageKeys.user, jsonEncode(userJson));
  }

  User? getUserJson() {
    final str = _preferences.getString(StorageKeys.user);
    if (str == null || str.isEmpty) return null;

    final map = jsonDecode(str) as Map<String, dynamic>;
    return User.fromJson(map);
  }

  Future<void> clearUser() async {
    await _preferences.remove(StorageKeys.user);
  }
}
