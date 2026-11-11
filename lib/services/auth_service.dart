import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class AuthService {

  static final AuthService instance = AuthService._();
  AuthService._();

  final String baseUrl = "https://dummyjson.com";

  String? token;
  String? firstName;

  bool get isLoggedIn => token != null;

  Future<void> login(String username, String password) async {
    final response = await http
        .post(
          Uri.parse("$baseUrl/auth/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "username": username,
            "password": password,
            "expiresInMins": 30,
          }),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data["accessToken"] ?? data["token"];
      firstName = data["firstName"] ?? username;
    } else if (response.statusCode == 400) {
      throw AuthException("Kullanıcı adı veya şifre hatalı.");
    } else {
      throw AuthException("Giriş yapılamadı. (${response.statusCode})");
    }
  }

  void logout() {
    token = null;
    firstName = null;
  }
}
