import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models.dart';

class PostPandaService {
  final String _baseUrl = 'http://127.0.0.1:8000/';

  Future<void> postPanda(PostPanda panda) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(panda.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to post panda');
    }
  }
}