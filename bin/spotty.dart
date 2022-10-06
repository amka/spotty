import 'package:args/args.dart';
import 'package:console/console.dart';
import 'package:spotty/models/location.dart';
import 'package:spotty/spotty.dart';

void main(List<String> arguments) async {
  Console.init();
  final parser = ArgParser()..addFlag('debug', help: 'enable debug mode');

  ArgResults argResults = parser.parse(arguments);

  if (argResults.rest.isEmpty) {
    return print('No location provided.');
  }

  final locationName = argResults.rest[0];
  final locations = await getCoordinates(locationName);

  if (locations == null) {
    return print('Location not found.');
  }

  var chooser = Chooser<Location>(
    locations,
    message: 'Select desired location: ',
    formatter: (choice, index) => '$index: ${choice.name}, ${choice.country}',
  );
  var location = chooser.chooseSync();
  print('Selected location is ${location.name}');

  final weather = await getCurrentWeather(location);

  if (weather == null) {
    return print('Couldn\'t get weather for given location: $location');
  }

  print('Weather: ${weather.temperature.toString()} °C');
}
