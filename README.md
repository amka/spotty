# Spotty

Console weather app.

## Usage

```bash
$ spotty --help
A command-line utility to get current weather

Usage: spotty <location>

Global options:
    --[no-]debug     enable debug mode
-t, --temp_unit      temperature units
                     [celsius (default), fahrenheit]
-w, --wind_unit      wind speed units
                     [kmh (default), ms, mph, kn]
-p, --prec_unit      precipitation units
                     [mm (default), inch]
-s, --[no-]select    select from found locations, otherwise first found will be used

See https://github.com/amka/spotty for detailed documentation.
```

## Example

```bash
$ spotty cairo
Cairo, Egypt 🌤  30.6°C
```

## Weather Data

[Weather data provided by Open-Meteo.com](https://open-meteo.com/).
