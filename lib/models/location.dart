class Location {
  final double latitude;
  final double longitude;
  final String name;
  final String? country;
  final String? countryCode;

  Location({
    required this.latitude,
    required this.longitude,
    required this.name,
    this.country,
    this.countryCode,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'],
        latitude: json['latitude'].toDouble(),
        longitude: json['longitude'].toDouble(),
        country: json['country'],
        countryCode: json['country_code'],
      );

  @override
  String toString() {
    return '<Location: $name, $country>';
  }
}
