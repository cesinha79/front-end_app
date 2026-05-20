import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://neuroquest-backend.onrender.com/api';

  Future<String?> login(String email, String password) async  {

    
    try {
      final response = await _dio.post(
        '$baseUrl/test-cors',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }  


Future<bool> register(String name, String email, String password) async {
  try {
    final response = await _dio.post(
     '$baseUrl/test-cors',
      data: {'name': name, 'email': email, 'password': password},
    );

    return response.statusCode == 201 || response.statusCode == 200;
  } catch (e) {
    print('Registration error: $e');
    return false;
  }
 } 
}
  