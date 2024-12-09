import 'package:spotty/spotty.dart';
import 'package:test/test.dart';

void main() {
  test('get coordinates', () async {
    final results = await getCoordinates("London");
    expect(results, isNotNull);
    expect(results, isNotEmpty);

    expect(results!.first.countryCode, "GB");
    expect(results.first.latitude, 51.50853);
    expect(results.first.longitude, -0.12574);
  });
}
