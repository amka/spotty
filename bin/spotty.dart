import 'dart:io';

import 'package:args/args.dart';
import 'package:console/console.dart';
import 'package:spotty/models/location.dart';
import 'package:spotty/spotty.dart';

void main(List<String> arguments) async {
  Console.init();
  final parser = createArgsParser();

  ArgResults argResults;
  try {
    argResults = parser.parse(arguments);
  } catch (e) {
    return printUsage(parser);
  }

  if (argResults.rest.isEmpty) {
    print('No location provided.');
    exit(404);
  }

  final locationName = argResults.rest.first;
  final locations = await getCoordinates(locationName);

  if (locations == null) {
    print('Location not found.');
    exit(404);
  }

  var location = locations.first;
  if (argResults['select']) {
    var chooser = Chooser<Location>(
      locations,
      message: 'Select location: ',
      formatter: (choice, index) =>
          '${index.toString().padLeft(2)}: ${choice.name}, ${choice.country}',
    );
    location = chooser.chooseSync();
  }

  final weather = await getCurrentWeather(location);

  if (weather == null) {
    print('Couldn\'t get weather for the given location: $location');
    exit(400);
  }

  printWeather(location, weather);
}

ArgParser createArgsParser() {
  return ArgParser()
    ..addFlag('debug', help: 'enable debug mode')
    ..addOption('temp_unit',
        abbr: 't',
        defaultsTo: 'celsius',
        allowed: ['celsius', 'fahrenheit'],
        help: 'temperature units')
    ..addOption('wind_unit',
        abbr: 'w',
        defaultsTo: 'kmh',
        allowed: ['kmh', 'ms', 'mph', 'kn'],
        help: 'wind speed units')
    ..addOption('prec_unit',
        abbr: 'p',
        defaultsTo: 'mm',
        allowed: ['mm', 'inch'],
        help: 'precipitation units')
    ..addFlag('select',
        abbr: 's',
        help:
            'select from found locations, otherwise first found will be used');
}

void printUsage(ArgParser parser) {
  print('A command-line utility to get current weather\n');
  print('Usage: spotty <location>\n');
  print('Global options:');
  print(parser.usage);
  print("\nSee https://github.com/amka/spotty for detailed documentation.");
}
