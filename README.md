# Spotty

Console weather app.

## Usage

```bash
$ spotty --help
A command-line utility to get current weather

Usage: spotty <location>

Global options:
    --[no-]debug    enable debug mode
-t, --temp_unit     temperature units
                    [celsius (default), fahrenheit]
-w, --wind_unit     wind speed units
                    [kmh (default), ms, mph, kn]
-p, --prec_unit     precipitation units
                    [mm (default), inch]

See https://github.com/amka/spotty for detailed documentation.
```

## Example

```bash
$ spotty london
1: London, United Kingdom
2: London, Canada
3: London, United States
4: London, United States
5: London, United States
6: London, United States
7: London, United States
8: London, United States
9: London Village, Kiribati
10: London, South Africa
Select desired location: 1
Selected location is London
Weather: 8.6 °C
```

## Weather Data

[Weather data provided by Open-Meteo.com](https://open-meteo.com/).
