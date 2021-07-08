import 'package:rest_api__crashcourse/app/services/api_keys.dart';

class API {
  final String apiKey;

  const API({required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.sandboxKey);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  
  Uri tokenUri() => Uri(
      scheme: 'https',
      host: host,
      path: 'token',
  );
}
