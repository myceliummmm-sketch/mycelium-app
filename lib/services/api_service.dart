import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  String? getToken() => _token;

  void clearToken() {
    _token = null;
  }

  Map<String, String> _getHeaders({bool withAuth = true}) {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (withAuth && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // Auth endpoints
  Future<Map<String, dynamic>> telegramAuth(String initData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/telegram'),
      headers: _getHeaders(withAuth: false),
      body: json.encode({'initData': initData}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setToken(data['token']);
      return data;
    } else {
      throw Exception('Auth failed: ${response.body}');
    }
  }

  // User endpoints
  Future<Map<String, dynamic>> getMe() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/users/me'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get user: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserById(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/users/$userId'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get user: ${response.body}');
    }
  }

  // Metaskills endpoints
  Future<Map<String, dynamic>> getMetaskills() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/metaskills'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get metaskills: ${response.body}');
    }
  }

  Future<List<dynamic>> getMetaskillsByDomain(String domain) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/metaskills/domain/$domain'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get metaskills: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateMetaskill(String id, double score) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/metaskills/$id'),
      headers: _getHeaders(),
      body: json.encode({'score': score}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update metaskill: ${response.body}');
    }
  }

  // Test endpoints
  Future<Map<String, dynamic>> submitTest({
    required String testType,
    required Map<String, dynamic> answers,
    required Map<String, dynamic> results,
    Map<String, dynamic>? sphereScores,
    List<Map<String, dynamic>>? metaskillUpdates,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/tests/$testType/submit'),
      headers: _getHeaders(),
      body: json.encode({
        'answers': answers,
        'results': results,
        'sphereScores': sphereScores,
        'metaskillUpdates': metaskillUpdates,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit test: ${response.body}');
    }
  }

  Future<List<dynamic>> getTestResults() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/tests/results'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get test results: ${response.body}');
    }
  }

  Future<List<dynamic>> getTestResultsByType(String testType) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/tests/results/$testType'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get test results: ${response.body}');
    }
  }

  // P2P endpoints
  Future<Map<String, dynamic>> matchP2P({
    List<String>? preferredSkills,
    int? duration,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/p2p/match'),
      headers: _getHeaders(),
      body: json.encode({
        'preferredSkills': preferredSkills,
        'duration': duration,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to match P2P: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> completeP2PCall({
    required String callId,
    int? rating,
    String? feedback,
    List<Map<String, dynamic>>? skillsObserved,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/p2p/$callId/complete'),
      headers: _getHeaders(),
      body: json.encode({
        'rating': rating,
        'feedback': feedback,
        'skillsObserved': skillsObserved,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to complete P2P call: ${response.body}');
    }
  }

  Future<List<dynamic>> getP2PHistory() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/p2p/history'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get P2P history: ${response.body}');
    }
  }

  // Leaderboard endpoints
  Future<Map<String, dynamic>> getTokenLeaderboard({int limit = 100}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/leaderboard/tokens?limit=$limit'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get leaderboard: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getLevelLeaderboard({int limit = 100}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/leaderboard/level?limit=$limit'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get leaderboard: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getMetaskillLeaderboard({
    required String domain,
    required String skill,
    int limit = 100,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/leaderboard/metaskills/$domain/$skill?limit=$limit'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get leaderboard: ${response.body}');
    }
  }
}
