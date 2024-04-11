import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sous_chef_app/services/openai/api_key.dart';

class OpenAI {
  static final Uri url = Uri.parse('https://api.openai.com/v1/images/generations');
  
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ApiKey.openAIApiKey}',
  };

  Future<String> generateImageUrl({
    required String prompt,
    required String size,
  }) async {
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'model': 'dall-e-3',
        'prompt': prompt,
        'size': size,
        'quality': 'standard',
        'n': 1,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'][0]['url'];
    } else {
      throw Exception('Failed to generate image: ${response.statusCode}');
    }
  }
}