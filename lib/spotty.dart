import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spotty/models/weather.dart';

import 'models/location.dart';

Future<List<Location>?> getCoordinates(String locationName) async {
  final uri = Uri.https(
      'geocoding-api.open-meteo.com', '/v1/search', {'name': locationName});
  final result = await http.get(uri);

  if (result.statusCode != HttpStatus.ok) return null;

  final jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
  return jsonBody['results']
      .map<Location>((item) => Location.fromJson(item))
      .toList();
}

Future<CurrentWeather?> getCurrentWeather(Location coordinates) async {
  final url = Uri.https(
    'api.open-meteo.com',
    '/v1/forecast',
    {
      'latitude': coordinates.latitude.toString(),
      'longitude': coordinates.longitude.toString(),
      'current_weather': true.toString()
    },
  );

  final result = await http.get(url);

  if (result.statusCode != HttpStatus.ok) return null;

  final jsonData = json.decode(result.body)['current_weather'];
  return CurrentWeather.fromJson(jsonData);
}
