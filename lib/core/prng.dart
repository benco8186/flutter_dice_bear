class PRNG {
  final String seed;
  int _value;

  PRNG._(this.seed, this._value);

  factory PRNG.create([String seed = '']) {
    // Ensure that seed is a string
    seed = seed.toString();

    int value = _hashSeed(seed);
    if (value == 0) value = 1;

    return PRNG._(seed, value);
  }

  int next() {
    _value = _xorshift(_value);
    return _value;
  }

  bool nextBool([int likelihood = 50]) {
    return integer(1, 100) <= likelihood;
  }

  int integer(int min, int max) {
    const int defaultMin = 1;
    const int defaultMax = 2147483647; // 2^31 - 1

    return ((next() - defaultMin) /
                (defaultMax - defaultMin) *
                (max + 1 - min) +
            min)
        .floor();
  }

  T? pick<T>(List<T> arr, [T? fallback]) {
    if (arr.isEmpty) {
      next();
      return fallback;
    }

    int index = integer(0, arr.length - 1);
    return index < arr.length ? arr[index] : fallback;
  }

  List<T> shuffle<T>(List<T> arr) {
    // Each method call should call the `next` function only once.
    // Therefore, we use a separate instance of the PRNG here.
    final internalPrng = PRNG.create(next().toString());

    // Fisher-Yates shuffle algorithm - We do not use the List.sort method
    // because it is not stable and produces different results when used in
    // different environments.
    final workingArray = List<T>.from(arr);

    for (int i = workingArray.length - 1; i > 0; i--) {
      final j = internalPrng.integer(0, i);

      // Swap elements
      final temp = workingArray[i];
      workingArray[i] = workingArray[j];
      workingArray[j] = temp;
    }

    return workingArray;
  }

  String string(
    int length, [
    String characters = 'abcdefghijklmnopqrstuvwxyz1234567890',
  ]) {
    // Each method call should call the `next` function only once.
    // Therefore, we use a separate instance of the PRNG here.
    final internalPrng = PRNG.create(next().toString());

    String str = '';

    for (int i = 0; i < length; i++) {
      str += characters[internalPrng.integer(0, characters.length - 1)];
    }

    return str;
  }

  // Helper methods (you'll need to implement these based on your original code)
  static int _hashSeed(String seed) {
    if (seed.isEmpty) return 1;

    int hash = 0;
    for (int i = 0; i < seed.length; i++) {
      final char = seed.codeUnitAt(i);
      hash = ((hash << 5) - hash) + char;
      hash = hash & hash; // Convert to 32-bit integer
    }

    return hash.abs();
  }

  static int _xorshift(int value) {
    value ^= value << 13;
    value ^= value >> 17;
    value ^= value << 5;
    return value & 0x7FFFFFFF; // Keep it positive and within 32-bit range
  }
}
