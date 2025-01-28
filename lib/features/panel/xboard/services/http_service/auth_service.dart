// services/auth_service.dart
import 'package:hiddify/features/panel/xboard/services/http_service/http_service.dart';

class AuthService {
  final HttpService _httpService = HttpService();

  // API 路径常量
  static const String _loginEndpoint = "/api/v1/passport/auth/login";
  static const String _registerEndpoint = "/api/v1/passport/auth/register";
  static const String _sendVerificationCodeEndpoint = "/api/v1/passport/comm/sendEmailVerify";
  static const String _resetPasswordEndpoint = "/api/v1/passport/auth/forget";

  Future<Map<String, dynamic>> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email and password cannot be empty.");
    }
    try {
      return await _httpService.postRequest(
        _loginEndpoint,
        {"email": email, "password": password},
        requiresHeaders: false,
      );
    } catch (error) {
      // 处理错误
      throw Exception("Login failed: $error");
    }
  }

  Future<Map<String, dynamic>> register(String email, String password,
      String inviteCode, String emailCode) async {
    if (email.isEmpty || password.isEmpty || inviteCode.isEmpty || emailCode.isEmpty) {
      throw Exception("All fields are required.");
    }
    try {
      return await _httpService.postRequest(
        _registerEndpoint,
        {
          "email": email,
          "password": password,
          "invite_code": inviteCode,
          "email_code": emailCode,
        },
      );
    } catch (error) {
      throw Exception("Registration failed: $error");
    }
  }

  Future<Map<String, dynamic>> sendVerificationCode(String email) async {
    if (email.isEmpty) {
      throw Exception("Email cannot be empty.");
    }
    try {
      return await _httpService.postRequest(
        _sendVerificationCodeEndpoint,
        {'email': email},
      );
    } catch (error) {
      throw Exception("Failed to send verification code: $error");
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      String email, String password, String emailCode) async {
    if (email.isEmpty || password.isEmpty || emailCode.isEmpty) {
      throw Exception("All fields are required.");
    }
    try {
      return await _httpService.postRequest(
        _resetPasswordEndpoint,
        {
          "email": email,
          "password": password,
          "email_code": emailCode,
        },
      );
    } catch (error) {
      throw Exception("Failed to reset password: $error");
    }
  }
}
