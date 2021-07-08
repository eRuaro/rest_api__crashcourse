import 'package:flutter/cupertino.dart';
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
    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<int> getEndpointData({
    required String accessToken,
    required EndPoint endpoint,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      Uri.parse(uri.toString()),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint]!;
        final int result = endpointData[responseJsonKey];
        return result;
      }
    }

    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Map<EndPoint, String> _responseJsonKeys = {
    EndPoint.cases: 'cases',
    EndPoint.casesConfirmed: 'cases_confirmed',
    EndPoint.casesSuspected: 'cases_suspected',
    EndPoint.deaths: 'deaths',
    EndPoint.recovered: 'recovered',
  };
}
