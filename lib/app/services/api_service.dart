import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rest_api__crashcourse/app/services/api.dart';

class APIService {
  const APIService({required this.api});

  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      Uri.parse(api.tokenUri().toString()),
      headers: {
        'Authorization': 'Basic ${api.apiKey}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];

      if (accessToken != null) {
        return accessToken;
      }
    }
    print('Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
