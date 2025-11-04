import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static const String _usersKey = 'users';
  static const String _currentUserKey =
      'current_user';
  static const String _isFirstLaunchKey =
      'is_first_launch';
  static const String _currentLanguageKey =
      'current_language';

  Future<bool> isFirstLaunch() async {
    final prefs =
        await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstLaunchKey) ??
        true;
  }

  Future<void> markAsLaunched() async {
    final prefs =
        await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstLaunchKey, false);
  }

  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final prefs =
        await SharedPreferences.getInstance();

    final usersJson = prefs.getString(_usersKey);
    Map<String, dynamic> users = {};

    if (usersJson != null) {
      users = Map<String, dynamic>.from(
        jsonDecode(usersJson),
      );
    }

    // Kiểm tra email đã tồn tại hay chưa
    if (users.containsKey(email)) {
      return false;
    }

    // Thêm người dùng mới
    users[email] = {
      'email': email,
      'password': password,
      'name': name,
      'created_at': DateTime.now()
          .toIso8601String(),
    };

    await prefs.setString(
      _usersKey,
      jsonEncode(users),
    );

    await prefs.setString(_currentUserKey, email);

    return true;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final prefs =
        await SharedPreferences.getInstance();

    final usersJson = prefs.getString(_usersKey);

    if (usersJson == null) {
      return false;
    }

    final users = Map<String, dynamic>.from(
      jsonDecode(usersJson),
    );

    // Kiểm tra người dùng có tồn tại và mật khẩu có khớp không
    if (!users.containsKey(email)) {
      return false;
    }

    final user = users[email];
    if (user['password'] != password) {
      return false;
    }

    // Thiết lập người dùng hiện tại
    await prefs.setString(_currentUserKey, email);

    return true;
  }

  // Lấy email của người dùng hiện tại
  Future<String?> getCurrentUserEmail() async {
    final prefs =
        await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }

  // Kiểm tra trạng thái đăng nhập
  Future<bool> isLoggedIn() async {
    final currentUser =
        await getCurrentUserEmail();
    return currentUser != null;
  }

  Future<String> getCurrentLanguage() async {
    final prefs =
        await SharedPreferences.getInstance();
    return prefs.getString(_currentLanguageKey) ??
        'vi';
  }

  Future<void> setLanguage(
    String languageCode,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();
    await prefs.setString(
      _currentLanguageKey,
      languageCode,
    );
  }
}
