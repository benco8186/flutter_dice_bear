import 'dart:math';

import 'package:flutter_dice_bear/src/models/avatar_style.dart';
import 'package:flutter_dice_bear/src/models/options.dart';
import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/models/style_create_result.dart';
import 'package:flutter_dice_bear/src/models/avatar_result.dart';
import 'package:flutter_dice_bear/src/utils/functions.dart';
import 'package:flutter_dice_bear/src/utils/licence_utils.dart';

typedef AvatarComponentBuilder =
    String Function({
      required PRNG prng,
      required AvatarOptions options,
      Map<String, dynamic> components,
      Map<String, String> colors,
    });

class AvatarGenerator {
  final AvatarStyle style;

  AvatarGenerator({required this.style});

  AvatarResult generate() {
    final prng = PRNG.create(style.options.seed);
    final result = style.create(prng: prng);
    final backgroundType = prng.pick(
      style.options.backgroundType ?? [],
      'solid',
    );
    final (
      String bgPrimaryColor,
      String bgSecondaryColor,
    ) = _getBackgroundColors(
      prng,
      style.options.backgroundColor ?? [],
      backgroundType,
    );
    final viewBoxParts = result.attributes.viewBox.split(' ');
    final x = double.parse(viewBoxParts[0]);
    final y = double.parse(viewBoxParts[1]);
    final vbW = double.parse(viewBoxParts[2]);
    final vbH = double.parse(viewBoxParts[3]);

    final bgRotationHasValues =
        style.options.backgroundRotation != null &&
        style.options.backgroundRotation!.isNotEmpty;
    final bgRotation = prng.integer(
      bgRotationHasValues ? style.options.backgroundRotation!.reduce(min) : 0,
      bgRotationHasValues ? style.options.backgroundRotation!.reduce(max) : 0,
    );
    if (style.options.size != null) {
      final size = style.options.size.toString();
      result.attributes["width"] = size;
      result.attributes["height"] = size;
    }
    if (style.options.scale != null && style.options.scale != 100) {
      result.body = _addScale(result, vbW, vbH, x, y, style.options.scale!);
    }
    if (style.options.flip) {
      result.body = addFlip(result, vbW, x);
    }
    if (style.options.rotate != null) {
      result.body = _addRotate(result, vbW, vbH, x, y, style.options.rotate!);
    }
    if (style.options.translateX != null || style.options.translateY != null) {
      result.body = _addTranslate(
        result,
        vbW,
        vbH,
        x,
        y,
        x: style.options.translateX!,
        y: style.options.translateY,
      );
    }
    if (bgPrimaryColor != 'transparent' && bgSecondaryColor != 'transparent') {
      result.body = _addBackground(
        result,
        vbW,
        vbH,
        x,
        y,
        bgPrimaryColor,
        bgSecondaryColor,
        backgroundType,
        bgRotation,
      );
    }
    if (style.options.radius != null || style.options.clip != null) {
      result.body = _addViewboxMask(
        result,
        vbW,
        vbH,
        x,
        y,
        style.options.radius ?? 0,
      );
    }
    if (style.options.randomizeIds) {
      result.body = _randomizeIds(result);
    }
    final attributes = createAttrString(result);
    final metadata = LicenceUtils.licenceToXml(style);
    final svg = "<svg $attributes>$metadata${result.body}</svg>";
    // Build the SVG

    return AvatarResult(
      svg: svg,
      extra: {
        "primaryBackgroundColor": bgPrimaryColor,
        "secondaryBackgroundColor": bgSecondaryColor,
        "backgroundType": backgroundType,
        "backgroundRotation": bgRotation,
        if (result.extra != null) ...result.extra!(),
      },
    );
  }

  (String primary, String secondary) _getBackgroundColors(
    PRNG prng,
    List<String> backgroundColor,
    String backgroundType,
  ) {
    List<String> shuffledBackgroundColors = prng.shuffle(backgroundColor);

    if (shuffledBackgroundColors.length <= 1 ||
        (backgroundColor.length == 2 && backgroundType == 'gradientLinear')) {
      shuffledBackgroundColors = backgroundColor;
      prng.next();
    } else {
      shuffledBackgroundColors = prng.shuffle(backgroundColor);
    }

    if (shuffledBackgroundColors.isEmpty) {
      shuffledBackgroundColors = ['transparent'];
    }

    final primary = shuffledBackgroundColors[0];
    final secondary = shuffledBackgroundColors.length > 1
        ? shuffledBackgroundColors[1]
        : shuffledBackgroundColors[0];
    final primaryColor = convertColor(primary);
    final secondaryColor = convertColor(secondary);
    return (primaryColor, secondaryColor);
  }

  String _addScale(
    StyleCreateResult result,
    double width,
    double height,
    double x,
    double y,
    double scale,
  ) {
    final double percent = scale != 0 ? (scale - 100) / 100 : 0;

    final double translateX = (width / 2 + x) * percent * -1;
    final double translateY = (height / 2 + y) * percent * -1;

    return '<g transform="translate($translateX $translateY) scale(${scale / 100})">${result.body}</g>';
  }

  String addFlip(StyleCreateResult result, double width, double x) {
    return '<g transform="scale(-1 1) translate(${width * -1 - x * 2} 0)">${result.body}</g>';
  }

  String _addRotate(
    StyleCreateResult result,
    double rotate,
    double width,
    double height,
    double x,
    double y,
  ) {
    return '<g transform="rotate($rotate, ${width / 2 + x}, ${height / 2 + y})">${result.body}</g>';
  }

  String _addTranslate(
    StyleCreateResult result,
    double width,
    double height,
    double vx,
    double vy, {
    double? x,
    double? y,
  }) {
    final double translateX = (width + vx * 2) * ((x ?? 0) / 100);
    final double translateY = (height + vy * 2) * ((y ?? 0) / 100);

    return '<g transform="translate($translateX $translateY)">${result.body}</g>';
  }

  String _addBackground(
    StyleCreateResult result,
    double width,
    double height,
    double x,
    double y,
    String primaryColor,
    String secondaryColor,
    String type, // 'solid' ou 'gradientLinear'
    int rotation,
  ) {
    final solidBackground =
        '<rect fill="$primaryColor" width="$width" height="$height" x="$x" y="$y" />';

    switch (type) {
      case 'solid':
        return solidBackground + result.body;

      case 'gradientLinear':
        return [
          '<rect fill="url(#backgroundLinear)" width="$width" height="$height" x="$x" y="$y" />',
          '<defs>',
          '<linearGradient id="backgroundLinear" gradientTransform="rotate($rotation 0.5 0.5)">',
          '<stop stop-color="$primaryColor"/>',
          '<stop offset="1" stop-color="$secondaryColor"/>',
          '</linearGradient>',
          '</defs>',
          result.body,
        ].join();
    }

    // Fallback si type inconnu
    return result.body;
  }

  String _addViewboxMask(
    StyleCreateResult result,
    double width,
    double height,
    double x,
    double y,
    double radius,
  ) {
    final double rx = radius != 0 ? (width * radius) / 100 : 0;
    final double ry = radius != 0 ? (height * radius) / 100 : 0;

    return [
      '<mask id="viewboxMask">',
      '<rect width="$width" height="$height" rx="$rx" ry="$ry" x="$x" y="$y" fill="#fff" />',
      '</mask>',
      '<g mask="url(#viewboxMask)">${result.body}</g>',
    ].join();
  }

  String _randomizeIds(StyleCreateResult result) {
    final prng = PRNG.create(); // random seed
    final ids = <String, String>{};

    final regex = RegExp(
      r'(id="|url\(#)([a-z0-9-_]+)([")])',
      caseSensitive: false,
    );

    return result.body.replaceAllMapped(regex, (match) {
      final m1 = match.group(1)!;
      final m2 = match.group(2)!;
      final m3 = match.group(3)!;

      ids[m2] = ids[m2] ?? prng.string(8);

      return '$m1${ids[m2]}$m3';
    });
  }
}
