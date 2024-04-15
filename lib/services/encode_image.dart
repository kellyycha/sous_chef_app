import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String?> networkImageToBase64(String imageUrl) async {
  try {
    http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      return base64Encode(bytes);
    } else {
      // Handle error
      print('Failed to load image: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // Handle exceptions
    print('Error loading image: $e');
    return null;
  }
}

Future<String?> fileImageToBase64(String image) async {
    final bytes = await File(image).readAsBytes();
    return base64Encode(bytes);
}