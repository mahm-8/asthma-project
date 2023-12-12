import 'dart:convert';
import 'package:asthma/Services/api_key.dart';
import 'package:http/http.dart' as http;

class Networking {
  final urlSK = 'https://api.openai.com/v1/chat/completions';
  Future<String> contectGpt({required String msg}) async {
    var url = Uri.parse(urlSK);
    var response = await http.post(url,
        headers: {
          'Content-Type': "application/json",
          'Authorization': 'Bearer $key'
        },
        body: json.encode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a chest doctor dedicated to answering questions related to asthma, helping people understand asthma and ways to reduce harm, and answering any question in this regard with correct, scientifically and health-related information"
            },
            {"role": "user", "content": msg}
          ],
          "temperature": 0,
          "max_tokens": 1024,
          "top_p": 1,
          "frequency_penalty": 0,
          "presence_penalty": 0
        }));
    final body = json.decode(response.body);
    return body['choices'][0]['message']['content'];
  }
}
