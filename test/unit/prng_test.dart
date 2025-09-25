import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PRNG', () {
    test('should generate consistent values with same seed', () {
      const seed = 'test-seed';
      final prng1 = PRNG.create(seed);
      final prng2 = PRNG.create(seed);

      // Generate a sequence of random numbers
      final sequence1 = List.generate(10, (_) => prng1.next());
      final sequence2 = List.generate(10, (_) => prng2.next());

      // Verify sequences are identical with same seed
      expect(sequence1, equals(sequence2));
    });

    test('should generate different values with different seeds', () {
      final prng1 = PRNG.create('seed1');
      final prng2 = PRNG.create('seed2');

      // Generate a random number from each PRNG
      final value1 = prng1.next();
      final value2 = prng2.next();

      // Verify values are different with different seeds
      expect(value1, isNot(equals(value2)));
    });

    test('nextInt should respect max value', () {
      const seed = 'test-seed';
      const max = 10;
      final prng = PRNG.create(seed);

      // Generate multiple values and verify they're within bounds
      for (var i = 0; i < 100; i++) {
        final value = prng.integer(0, max);
        expect(value, greaterThanOrEqualTo(0));
        expect(value, lessThan(max));
      }
    });

    test('pickFrom should return null for empty list', () {
      final prng = PRNG.create('test');
      final result = prng.pick(<String>[]);
      expect(result, isNull);
    });

    test('pickFrom should return item from list', () {
      final prng = PRNG.create('test');
      final items = ['a', 'b', 'c'];
      final result = prng.pick(items);

      expect(items, contains(result));
    });

    test('should generate different sequences for different seeds', () {
      final prng1 = PRNG.create('seed1');
      final prng2 = PRNG.create('seed2');

      final seq1 = List.generate(5, (_) => prng1.next());
      final seq2 = List.generate(5, (_) => prng2.next());

      expect(seq1, isNot(equals(seq2)));
    });
  });
}
