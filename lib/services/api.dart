import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:museum/models/coordinate.dart';
import 'package:museum/models/player.dart';
import 'dart:convert';

import '../models/satellite.dart';

final dataBaseUrl = 'https://orbitar-data-api.herokuapp.com/api/v1';
final backendBaseUrl = 'http://32e411f3.ngrok.io';
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

Future<Coordinate> getCoordinates(String satelliteId, String latitude, String longitude, String altitude) async {
  var response = await http.get('$dataBaseUrl/coordinates/$satelliteId/?lat=$latitude&lon=$longitude&alt=$altitude',
      headers: headers);

  var parsedBody = json.decode(utf8.decode(response.bodyBytes));

  return Coordinate.fromJson(parsedBody);
}