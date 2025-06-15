extension StringExtension on String {
  String get initial {
    final tokens = split(' ');
    if (tokens.length > 1) {
      final token0 = tokens.firstWhere((token) => num.tryParse(token) == null);
      return token0[0];
    }
    return this[0];
  }

  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
