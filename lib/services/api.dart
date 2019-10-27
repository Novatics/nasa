import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/satellite.dart';

final dataBaseUrl = 'http://10.0.2.2:8000/api/v1';

Future<List<Satellite>> getSatellites() async {
  final response = await http.get('$dataBaseUrl/satellites');
  final decodedBody = json.decode(utf8.decode(response.bodyBytes));
  return List<Satellite>.from(decodedBody.map((s) => Satellite.fromJson(s)));
}
