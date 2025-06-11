import 'dart:convert';
import 'package:http/http.dart' as http;

class FastApiService {
  static const String baseUrl =
      "https://worthy-youthfulness-production.up.railway.app";
  static const Duration timeout = Duration(seconds: 30);

  static Future<String> askQuestion(String question) async {
    final url = Uri.parse("$baseUrl/ask");
    print('🌐 Sending to: $url');
    print('📝 Question: "$question"');

    try {
      final response = await http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': question}),
      )
          .timeout(timeout);

      print('⚡ Response Status: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['answer'] ??
            data['response'] ??
            'Unexpected response format: ${response.body}';
      } else {
        return 'Server error (${response.statusCode}): ${response.body}';
      }
    } catch (e) {
      print('❌ Error: $e');
      return 'Failed to get response: ${e.toString()}';
    }
  }
}