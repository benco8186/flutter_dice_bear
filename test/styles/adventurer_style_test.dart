import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/adventurer_options.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/adventurer_style.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdventurerStyle', () {
    late AdventurerStyle style;
    late PRNG prng;

    setUp(() {
      prng = PRNG.create('test-seed');
      style = AdventurerStyle(options: AdventurerOptions(seed: 'test-seed'));
    });

    test('should create SVG with all components', () {
      final result = style.create(prng: prng);

      expect(result, isNotNull);
      expect(result.body, isNotEmpty);

      expect(result.attributes['viewBox'], equals('0 0 762 762'));

      expect(result.body.contains('transform="translate(-161 -83)"'), isTrue);
    });

    test('should hide earrings for specific hair styles', () {
      final result = AdventurerStyle(
        options: AdventurerOptions(seed: 'test-seed', hair: ["long26"]),
      ).create(prng: prng);

      expect(result.body.contains('earrings'), isFalse);
    });

    test('should apply correct SVG attributes', () {
      final result = style.create(prng: prng);

      expect(result.attributes['fill'], 'none');
      expect(result.attributes['shape-rendering'], 'auto');
    });
  });
}
