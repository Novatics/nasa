import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/satellite.dart';

final dataBaseUrl = 'http://10.0.2.2:8000/api/v1';
final backendBaseUrl = 'http://10.0.2.2:3000';

Future<List<Satellite>> getSatellites() async {
  final response = await http.get('$dataBaseUrl/satellites');
  final decodedBody = json.decode(utf8.decode(response.bodyBytes));
  return List<Satellite>.from(decodedBody.map((s) => Satellite.fromJson(s)));
}

Future<String> createGame(List<int> satellitesIds) async {
  var response = await http.post(
    '$backendBaseUrl/games',
    headers: {"Content-Type": "application/json"},
    body: json.encode({'satellites': satellitesIds}),
  );
  var parsedBody = json.decode(utf8.decode(response.bodyBytes));

  return parsedBody['code'];
}
