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
            {"role": "user", "content": msg}
          ],
          "temperature": 1,
          "max_tokens": 256,
          "top_p": 1,
          "frequency_penalty": 0,
          "presence_penalty": 0
        }));

    final body = json.decode(response.body);
    print(body);

    return body['choices'][0]['message']['content'];
  }

  Future<String> getAirQuality() async {
    final urlImage =
        'https://api.openaq.org/v2/projects?parameter=100&unit=1&project_id=0&project=asc&source_name=lastUpdated';
    var url = Uri.parse(urlImage);
    var response = await http.post(url,
        headers: {
          "Authorization": "Bearer ${airKey}",
          "Content-Type": "application/json"
        },
        body: json.encode({
          'type': 'missing',
          'loc': ('query', 'country_id'),
          'msg': 'Field required',
          'input': '',
          'url': 'https://errors.pydantic.dev/2.1.2/v/missing'
        }));
    final body = json.decode(response.body);
    return body['data'][0]['url'];
    // final pathImage = await saveImageIn(
    //     url: body['data'][0]['url'], nameImage: DateTime.now().toString());
    // await supabaseStorge().uploadImage(pathImagefile: pathImage);
    // return pathImage;
  }

  var apiUrl = 'https://api.openaq.org/v1/measurements';

  Future<List<dynamic>> airQualityMethod(country, city) async {
    try {
      final response = await http
          .get(Uri.parse('${apiUrl}?country=${country}&city=${city}'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['results'];
      } else {
        throw Exception('Failed to fetch air quality data');
      }
    } catch (error) {
      print(error);
      return [];
    }
  }
}
