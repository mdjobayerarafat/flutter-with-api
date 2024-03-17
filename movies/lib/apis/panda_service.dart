import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/panda_list.dart';

class PandaService {
  final String _baseUrl = 'http://127.0.0.1:8000/';

  Future<PandaList> fetchPandas() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return PandaList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pandas');
    }
  }
}