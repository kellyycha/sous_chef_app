import 'package:http/http.dart' as http;
import 'api_key.dart';
import 'chat_request.dart';
import 'chat_response.dart';

class ChatService {
  static final Uri chatUri = Uri.parse('https://api.openai.com/v1/chat/completions');

  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ApiKey.openAIApiKey}',
  };

  Future<String?> request(String prompt) async {
    try {
      // Check if prompt is empty 
      if (prompt.isEmpty) {
        return null;
      }
      
      // Construct the request object
      ChatRequest request = ChatRequest(model: "gpt-3.5-turbo", maxTokens: 150, messages: [Message(role: "system", content: prompt)]);

      // Make the API call
      http.Response response = await http.post(
        chatUri,
        headers: headers,
        body: request.toJson(),
      );

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response
        ChatResponse chatResponse = ChatResponse.fromResponse(response);
        print(chatResponse.choices?[0].message?.content);
        return chatResponse.choices?[0].message?.content;
      } else {
        // Handle other unsuccessful responses
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle any exceptions
      print("Error: $e");
      return null;
    }
  }
}
