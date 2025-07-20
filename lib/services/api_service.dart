import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiService {
  static final _logger = Logger('ApiService');

  static String get baseUrl {
    if (kIsWeb) {
      // Use localhost if backend is running on your PC
      return 'http://localhost:8080/api';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api';
    } else if (Platform.isIOS) {
      return 'http://localhost:8080/api';
    } else {
      return 'http://localhost:8080/api';
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      _logger.info('Attempting to connect to: $baseUrl/auth/login');
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      _logger.severe('Error during login: $e');
      throw Exception(
        'Failed to connect to the server. Please make sure the server is running.',
      );
    }
  }
}
