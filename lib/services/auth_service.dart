import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  final String baseUrl =
      'http://localhost:3000/api';

  Future<String?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      }

      return null;

    } catch (e) {
      print('Erro login: $e');
      return null;
    }
  }
  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/register',
        data: {
          'nome': name,
          'email': email,
          'password': password,
        },
      );

      print("DADOS: ${response.data}");

      return response.statusCode == 201;

    } catch (e) {
      print('Erro cadastro: $e');
      return false;
    }
  }
}