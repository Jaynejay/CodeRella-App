import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // Replace with your actual backend URL
  final String baseUrl = 'http://localhost:8080'; // Android emulator localhost
  // For iOS simulator use 'http://localhost:8080'
  // For physical device use your computer's IP address like 'http://192.168.1.100:8080'

  // Get all users
  Future<List<dynamic>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  // Add a new user
  Future<Map<String, dynamic>> addUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to add user');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }
}