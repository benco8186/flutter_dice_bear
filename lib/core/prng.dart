abstract class PRNG {
  static const int min = -2147483648;
  static const int max = 2147483647;
  String get seed;
  int next();
  bool nextBool([int likelihood = 50]);
  int integer(int min, int max);
  T? pick<T>(List<T> arr, [T? fallback]);
  List<T> shuffle<T>(List<T> arr);
  String string(
    int length, [
    String characters = 'abcdefghijklmnopqrstuvwxyz1234567890',
  ]);
  PRNG();
  factory PRNG.create([String seed = '']) {
    int value = hashSeed(seed);

    if (value == 0) value = 1;
    return _PRNGImpl(seed, value);
  }
}

int xorshift(int value) {
  value = toInt32(value ^ (value << 13));
  value = toInt32(value ^ (value >> 17));
  value = toInt32(value ^ (value << 5));
  // value = value ^ (value << 13);
  // value = value ^ (value >> 17);
  // value = value ^ (value << 5);
  return value;
}

int hashSeed(String seed) {
  int hash = 0;

  for (int i = 0; i < seed.length; i++) {
    hash = toInt32(((hash << 5) - hash + seed.codeUnitAt(i)));
    hash = xorshift(hash);
  }

  return hash;
}

int toInt32(int value) {
  // Simule le comportement JavaScript des entiers 32-bit signés
  value = value & 0xFFFFFFFF; // Masque sur 32 bits
  if (value > 0x7FFFFFFF) {
    value = value - 0x100000000; // Convertit en signé
  }
  return value;
}

// PRNG implementation
class _PRNGImpl extends PRNG {
  @override
  final String seed;
  int _value;

  _PRNGImpl(this.seed, this._value);

  @override
  int next() => _value = xorshift(_value);

  int _integer(int min, int max) {
    final nextNb = next();
    double result =
        ((nextNb - PRNG.min) / (PRNG.max - PRNG.min)) * (max + 1 - min) + min;
    return result.floor();
  }

  @override
  bool nextBool([int likelihood = 50]) {
    return integer(1, 100) <= likelihood;
  }

  @override
  int integer(int min, int max) {
    return _integer(min, max);
  }

  @override
  T? pick<T>(List<T> arr, [T? fallback]) {
    if (arr.isEmpty) {
      next();
      return fallback;
    }
    //
    int index = integer(0, arr.length - 1);
    return (index >= 0 && index < arr.length) ? arr[index] : fallback;
  }

  @override
  List<T> shuffle<T>(List<T> arr) {
    final nextNb = next();
    final internalPrng = PRNG.create(nextNb.toString());

    final workingArray = List<T>.from(arr);
    for (int i = workingArray.length - 1; i > 0; i--) {
      final j = internalPrng.integer(0, i);
      final temp = workingArray[i];
      workingArray[i] = workingArray[j];
      workingArray[j] = temp;
    }
    return workingArray;
  }

  @override
  String string(
    int length, [
    String characters = 'abcdefghijklmnopqrstuvwxyz1234567890',
  ]) {
    final internalPrng = PRNG.create(next().toString());

    String str = '';

    for (int i = 0; i < length; i++) {
      str += characters[internalPrng.integer(0, characters.length - 1)];
    }

    return str;
  }
}
