import 'package:flutter/material.dart';
import 'package:rest_api__crashcourse/app/services/api.dart';
import 'package:rest_api__crashcourse/app/services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _accessToken = '';
  int _cases = 0;

  void _getToken() async {
    final apiService = APIService(api: API.sandbox());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndpointData(
        accessToken: accessToken, endpoint: EndPoint.cases);
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              _getToken();
            },
            color: Colors.blue,
          ),
          Text(_accessToken),
          Text(_cases.toString()),
        ],
      ),
    );
  }
}
