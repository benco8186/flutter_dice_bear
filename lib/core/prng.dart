import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// A deterministic pseudorandom number generator
class PRNG {
  static const _maxInt = 0x7FFFFFFF;
  final List<int> _seed;
  int _seedIndex = 0;
  int _currentSeed = 0;
  final Random _random = Random();

  PRNG(String seed) : _seed = _hashSeed(seed);

  static List<int> _hashSeed(String seed) {
    final bytes = utf8.encode(seed);
    final digest = md5.convert(bytes);
    return digest.bytes;
  }

  /// Returns a random float between 0 (inclusive) and 1 (exclusive)
  double nextDouble() {
    if (_seedIndex >= _seed.length) {
      _currentSeed = _random.nextInt(_maxInt);
      _seedIndex = 0;
    }

    final byte = _seed[_seedIndex++];
    return byte / 256.0;
  }

  /// Returns a random integer between min (inclusive) and max (exclusive)
  int nextInt(int min, [int? max]) {
    if (max == null) {
      max = min;
      min = 0;
    }

    if (min >= max) return min;

    final range = max - min;
    return min + (nextDouble() * range).floor();
  }

  /// Picks a random item from the given list
  T pick<T>(List<T> items, [T? defaultValue]) {
    if (items.isEmpty) {
      if (defaultValue != null) return defaultValue;
      throw ArgumentError('Cannot pick from an empty list');
    }

    return items[nextInt(0, items.length)];
  }

  /// Returns a boolean with the given probability (0.0 to 1.0)
  bool nextBool([double probability = 0.5]) {
    return nextDouble() < probability;
  }

  /// Returns a random number with normal distribution
  double nextGaussian({double mean = 0.0, double stdDev = 1.0}) {
    // Box-Muller transform
    double u1 = 1.0 - nextDouble(); // [0, 1) -> (0, 1]
    double u2 = 1.0 - nextDouble();
    double z0 = sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2);

    return mean + stdDev * z0;
  }
}
