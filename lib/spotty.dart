import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:console/console.dart';
import 'package:http/http.dart' as http;
import 'package:spotty/models/weather.dart';

import 'models/location.dart';

Future<List<Location>?> getCoordinates(String locationName,
    {int count = 5}) async {
  final uri = Uri.https(
    'geocoding-api.open-meteo.com',
    '/v1/search',
    {'name': locationName, 'count': count.toString()},
  );

  try {
    final result = await http.get(uri).timeout(Duration(seconds: 5));

    if (result.statusCode != HttpStatus.ok) return null;

    final jsonBody = jsonDecode(result.body) as Map<String, dynamic>;
    if (jsonBody['results'] == null) return null;

    return jsonBody['results']
        .map<Location>((item) => Location.fromJson(item))
        .toList();
  } on TimeoutException {
    print('Operation timed out');
    return null;
  } catch (e) {
    print('Error occured while getting location coordinates: $e');
    return null;
  }
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

  try {
    final result = await http.get(url).timeout(Duration(seconds: 5));
    if (result.statusCode != HttpStatus.ok) return null;

    final jsonData = json.decode(result.body)['current_weather'];
    return CurrentWeather.fromJson(jsonData);
  } on TimeoutException {
    print('Operation timed out');
    return null;
  } catch (e) {
    print('Error occured while getting location coordinates: $e');
    return null;
  }
}

void printWeather(Location location, CurrentWeather weather) {
  final temp = weather.temperature > 0
      ? format('{color.gold}${weather.temperature}{color.end}')
      : format('{color.blue}${weather.temperature}{color.end}');

  var condition = '🌚';
  switch (weather.weatherCode) {
    case 0:
      // 	Clear sky
      condition = '☀️';
      break;
    case 1:
      // Mainly clear
      condition = '🌤';
      break;
    case 2:
      // Partly cloudy
      condition = '⛅️';
      break;
    case 3:
      // 	Overcast
      condition = '☁️';
      break;
    default:
      break;
  }
  print('${location.name}, ${location.country} $condition  $temp°C');
}
