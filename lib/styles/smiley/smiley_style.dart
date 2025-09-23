import 'package:flutter_dice_bear/core/avatar_generator.dart';
import 'package:flutter_dice_bear/core/prng.dart';
import 'package:flutter_dice_bear/core/svg/svg_builder.dart';
import 'smiley_options.dart';

/// A simple smiley face avatar style that demonstrates how to create a custom style.
class SmileyStyle extends AvatarStyle<SmileyOptions> {
  @override
  final String name = 'smiley';

  @override
  final String license = 'MIT';

  @override
  final String creator = 'DiceBear Team';

  @override
  final String source = 'https://dicebear.com';

  @override
  final String version = '1.0.0';

  @override
  final String viewBox = '0 0 200 200';

  @override
  final SmileyOptions defaultOptions = const SmileyOptions();

  @override
  final Map<String, dynamic> schema = {
    'size': {'type': 'number', 'default': 200.0, 'minimum': 10, 'maximum': 500},
    'faceColor': {'type': 'string', 'default': '#FFD700', 'format': 'color'},
    'featureColor': {'type': 'string', 'default': '#000000', 'format': 'color'},
    'isHappy': {'type': 'boolean', 'default': true},
    'hasGlasses': {'type': 'boolean', 'default': false},
  };

  @override
  Map<String, dynamic> create({
    required PRNG prng,
    required SmileyOptions options,
  }) {
    final face = _createFace(options);
    final leftEye = _createEye(50, 70, options);
    final rightEye = _createEye(150, 70, options);
    final mouth = _createMouth(100, 130, options);

    String? glasses;
    if (options.hasGlasses) {
      glasses = _createGlasses(options);
    }

    return {
      'face': face,
      'leftEye': leftEye,
      'rightEye': rightEye,
      'mouth': mouth,
      if (glasses != null) 'glasses': glasses,
    };
  }

  String _createFace(SmileyOptions options) {
    return SvgBuilder.circle(
      cx: 100,
      cy: 100,
      r: 90,
      attributes: {
        'fill': options.faceColor,
        'stroke': options.featureColor,
        'stroke-width': '4',
      },
    );
  }

  String _createEye(double cx, double cy, SmileyOptions options) {
    return SvgBuilder.circle(
      cx: cx,
      cy: cy,
      r: 10,
      attributes: {'fill': options.featureColor},
    );
  }

  String _createMouth(double cx, double cy, SmileyOptions options) {
    if (options.isHappy) {
      // Happy mouth (smile)
      return SvgBuilder.path(
        'M 50 $cy Q $cx 180 150 $cy',
        attributes: {
          'stroke': options.featureColor,
          'stroke-width': '6',
          'fill': 'none',
          'stroke-linecap': 'round',
        },
      );
    } else {
      // Sad mouth (frown)
      return SvgBuilder.path(
        'M 50 ${cy + 20} Q $cx $cy 150 ${cy + 20}',
        attributes: {
          'stroke': options.featureColor,
          'stroke-width': '6',
          'fill': 'none',
          'stroke-linecap': 'round',
        },
      );
    }
  }

  String _createGlasses(SmileyOptions options) {
    // Glasses frame
    final leftLens = SvgBuilder.circle(
      cx: 60,
      cy: 70,
      r: 25,
      attributes: {
        'fill': 'none',
        'stroke': options.featureColor,
        'stroke-width': '3',
      },
    );

    final rightLens = SvgBuilder.circle(
      cx: 140,
      cy: 70,
      r: 25,
      attributes: {
        'fill': 'none',
        'stroke': options.featureColor,
        'stroke-width': '3',
      },
    );

    // Bridge of the glasses
    final bridge = SvgBuilder.rect(
      x: 85,
      y: 70,
      width: 30,
      height: 5,
      attributes: {'fill': options.featureColor},
    );

    return '$leftLens$rightLens$bridge';
  }
}
