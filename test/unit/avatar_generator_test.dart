import 'package:flutter_dice_bear/src/core/avatar_generator.dart';
import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/models/avatar_style.dart';
import 'package:flutter_dice_bear/src/models/options.dart';
import 'package:flutter_dice_bear/src/models/style_create_result.dart';
import 'package:flutter_dice_bear/src/models/style_meta.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock implementation of AvatarStyle for testing
class MockStyle extends AvatarStyle {
  @override
  final AvatarOptions options;
  
  @override
  // Mock style metadata
  final StyleMeta meta = StyleMeta(
    title: 'Mock Style',
    creator: 'Test',
    source: 'https://example.com',
  );

  MockStyle({required this.options});

  @override
  // Create a mock avatar with the PRNG seed
  StyleCreateResult create({required PRNG prng}) {
    final seed = prng.seed;
    return StyleCreateResult(
      // Simple viewBox for the mock SVG
      attributes: StyleCreateResultAttributes(viewBox: '0 0 200 200'),
      // SVG body with the seed for testing
      body: '<g><text>mock-avatar-$seed</text></g>',
      // Include seed in extra data for verification
      extra: () => {'seed': seed},
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('AvatarGenerator', () {
    late AvatarGenerator generator;

    setUp(() {
      generator = AvatarGenerator(
        style: MockStyle(options: AvatarOptions(seed: 'test-seed')),
      );
    });

    test('should generate avatar with default options', () {
      final result = generator.generate();

      expect(result, isNotNull);
      expect(result.svg, contains('mock-avatar'));
      expect(result.svg, startsWith('<svg'));
      expect(result.svg, endsWith('</svg>'));
    });

    test('should use provided seed for consistent generation', () {
      const seed = 'consistent-seed';
      final generator1 = AvatarGenerator(
        style: MockStyle(options: AvatarOptions(seed: seed)),
      );
      final generator2 = AvatarGenerator(
        style: MockStyle(options: AvatarOptions(seed: seed)),
      );

      final result1 = generator1.generate();
      final result2 = generator2.generate();

      // Verify that the same seed produces identical SVGs
      expect(result1.svg, equals(result2.svg));
      
      // Verify the seed is included in the generated SVG
      expect(result1.svg, contains(seed));
    });
  });
}
