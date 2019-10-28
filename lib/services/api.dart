import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:museum/models/player.dart';
import 'dart:convert';

import '../models/satellite.dart';

final dataBaseUrl = 'http://10.0.2.2:8000/api/v1';
final backendBaseUrl = 'http://10.0.2.2:3000';
final headers = {"Content-Type": "application/json"};

Future<List<Satellite>> getSatellites() async {
  final response = await http.get('$dataBaseUrl/satellites');
  final decodedBody = json.decode(utf8.decode(response.bodyBytes));
  return List<Satellite>.from(decodedBody.map((s) => Satellite.fromJson(s)));
}

Future<String> createGame(List<int> satellitesIds) async {
  var response = await http.post(
    '$backendBaseUrl/games',
    headers: headers,
    body: json.encode({'satellites': satellitesIds}),
  );
  var parsedBody = json.decode(utf8.decode(response.bodyBytes));

  return parsedBody['code'];
}

Future<Player> joinGame(String code, String nickname) async {
  var response = await http.post('$backendBaseUrl/games/join',
      headers: headers,
      body: json.encode({'code': code, 'nickname': nickname}));

  var parsedBody = json.decode(utf8.decode(response.bodyBytes));

  return Player.fromJson(parsedBody);
}
