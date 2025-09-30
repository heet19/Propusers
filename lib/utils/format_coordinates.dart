String formatCoordinates(double? lat, double? lng) {
  String latText = '';
  String lngText = '';

  if (lat != null) {
    latText = '${lat.abs().toStringAsFixed(3)}° ${lat >= 0 ? "N" : "S"}';
  }
  if (lng != null) {
    lngText = '${lng.abs().toStringAsFixed(3)}° ${lng >= 0 ? "E" : "W"}';
  }

  if (latText.isNotEmpty && lngText.isNotEmpty) {
    return '$latText | $lngText';
  } else if (latText.isNotEmpty) {
    return latText;
  } else if (lngText.isNotEmpty) {
    return lngText;
  } else {
    return 'N/A';
  }
}
