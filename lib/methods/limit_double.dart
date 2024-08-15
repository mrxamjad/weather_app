double limitDecimalPlaces(double number, int decimalPlaces) {
  if (decimalPlaces < 0) {
    throw ArgumentError('Decimal places must be non-negative');
  }

  String numString = number.toStringAsFixed(decimalPlaces);
  return double.parse(numString);
}
