import 'package:http/http.dart' as http;
import 'package:rest_api__crashcourse/app/services/api.dart';

class APIService {
  const APIService({required this.api});

  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      Uri.parse(api.tokenUri().toString()),
      headers: {
        'Authorization': 'Basic ${api.apiKey}',
      }
    );
  }
}
