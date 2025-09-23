import 'package:xml/xml.dart' as xml;

import '../models/avatar_result.dart';
import 'prng.dart';
import 'options.dart';
import 'svg/svg_builder.dart';

/// A function that creates an avatar component based on the given PRNG and options
typedef AvatarComponentBuilder<T> =
    String Function({
      required PRNG prng,
      required T options,
      Map<String, dynamic> components,
      Map<String, String> colors,
    });

/// Base class for all avatar styles
abstract class AvatarStyle<T> {
  /// The name of the style
  String get name;

  /// The license information for the style
  String get license;

  /// The creator of the style
  String get creator;

  /// The source of the style (e.g., Figma URL)
  String get source;

  /// The version of the style
  String get version;

  /// The viewBox for the SVG
  String get viewBox;

  /// The default options for the style
  T get defaultOptions;

  /// The schema for the style options
  Map<String, dynamic> get schema;

  /// Creates the avatar components
  Map<String, dynamic> create({required PRNG prng, required T options});
}

/// The main class for generating avatars
class AvatarGenerator<T> {
  final AvatarStyle<T> _style;
  final AvatarOptions _defaultOptions;

  /// Creates a new AvatarGenerator with the given style and default options
  AvatarGenerator({
    required AvatarStyle<T> style,
    AvatarOptions? defaultOptions,
  }) : _style = style,
       _defaultOptions = defaultOptions ?? const AvatarOptions(seed: '');

  /// Generates an avatar with the given options
  AvatarResult generate([T? options]) {
    final mergedOptions = _mergeOptions(options);
    final prng = PRNG(mergedOptions.seed);

    // Create the avatar components
    final components = _style.create(
      prng: prng,
      options: options ?? _style.defaultOptions,
    );

    // Build the SVG
    final svg = _buildSvg(prng, mergedOptions, components);

    return AvatarResult(
      svg: svg,
      extra: {
        'style': _style.name,
        'version': _style.version,
        'seed': mergedOptions.seed,
        ...components,
      },
    );
  }

  /// Merges the given options with the default options
  AvatarOptions _mergeOptions(T? options) {
    // Start with default options
    var merged = _defaultOptions.copyWith(
      seed: _defaultOptions.seed.isEmpty
          ? DateTime.now().millisecondsSinceEpoch.toString()
          : _defaultOptions.seed,
    );

    // Apply style-specific options if provided
    if (options != null) {
      // Style-specific options are already applied through the options parameter
      // No additional merging needed as they're handled by the style implementation
    }

    return merged;
  }

  /// Builds the SVG for the avatar
  String _buildSvg(
    PRNG prng,
    AvatarOptions options,
    Map<String, dynamic> components,
  ) {
    final builder = SvgBuilder('svg')
      ..addAttribute('viewBox', _style.viewBox)
      ..addAttribute('width', options.size?.toString() ?? '100%')
      ..addAttribute('height', options.size?.toString() ?? '100%')
      ..addAttribute('fill', 'none')
      ..addAttribute('shape-rendering', 'auto')
      ..addAttribute('xmlns', 'http://www.w3.org/2000/svg');

    // Add background if needed
    final background = _createBackground(prng, options);
    if (background != null) {
      builder.addChild(background);
    }

    // Add avatar components
    for (final component in components.values) {
      if (component is String) {
        builder.addChild(component);
      }
    }

    // Apply transformations
    var svg = builder.build();

    if (options.scale != null && options.scale != 100) {
      svg = _applyScale(svg, options.scale!);
    }

    if (options.flip) {
      svg = _applyFlip(svg);
    }

    if (options.rotate != null) {
      svg = _applyRotate(svg, options.rotate!);
    }

    if (options.translateX != null || options.translateY != null) {
      svg = _applyTranslate(
        svg,
        options.translateX ?? 0,
        options.translateY ?? 0,
      );
    }

    if (options.radius != null || options.clip == true) {
      svg = _applyClip(svg, options.radius ?? 0);
    }

    return svg;
  }

  /// Creates the background for the avatar
  String? _createBackground(PRNG prng, AvatarOptions options) {
    final backgroundColor = options.backgroundColor?.isNotEmpty == true
        ? prng.pick(options.backgroundColor!)
        : 'transparent';

    if (backgroundColor == 'transparent') {
      return null;
    }

    final backgroundType = prng.pick(options.backgroundType ?? ['solid']);

    if (backgroundType == 'solid') {
      return SvgBuilder.rect(
        width: double.parse(_style.viewBox.split(' ')[2]),
        height: double.parse(_style.viewBox.split(' ')[3]),
        attributes: {'fill': backgroundColor},
      );
    } else if (backgroundType == 'gradient') {
      // Simple gradient implementation
      final gradientId = 'gradient-${DateTime.now().millisecondsSinceEpoch}';
      final gradient = SvgBuilder.linearGradient(
        id: gradientId,
        stops: [
          MapEntry(0, backgroundColor),
          MapEntry(100, _adjustColorBrightness(backgroundColor, 30)),
        ],
      );

      return gradient +
          SvgBuilder.rect(
            width: double.parse(_style.viewBox.split(' ')[2]),
            height: double.parse(_style.viewBox.split(' ')[3]),
            attributes: {'fill': 'url(#$gradientId)'},
          );
    }

    return null;
  }

  /// Helper method to adjust color brightness
  String _adjustColorBrightness(String color, int amount) {
    // Simple implementation - in a real app, use a proper color manipulation library
    try {
      if (color.startsWith('#')) {
        final buffer = StringBuffer();
        buffer.write('#');
        for (int i = 0; i < 3; i++) {
          final part = int.parse(
            color.substring(i * 2 + 1, i * 2 + 3),
            radix: 16,
          );
          final adjusted = (part + amount)
              .clamp(0, 255)
              .toRadixString(16)
              .padLeft(2, '0');
          buffer.write(adjusted);
        }
        return buffer.toString();
      }
    } catch (e) {
      // If there's an error, return the original color
    }
    return color;
  }

  /// Applies scaling to the SVG
  String _applyScale(String svg, int scale) {
    final scaleFactor = scale / 100.0;
    final doc = xml.XmlDocument.parse(svg);
    final svgElement = doc.findElements('svg').first;

    svgElement.attributes.add(
      xml.XmlAttribute(xml.XmlName('transform'), 'scale($scaleFactor)'),
    );

    return doc.toXmlString(pretty: true);
  }

  /// Applies horizontal flip to the SVG
  String _applyFlip(String svg) {
    final doc = xml.XmlDocument.parse(svg);
    final svgElement = doc.findElements('svg').first;

    final viewBox =
        svgElement.getAttribute('viewBox')?.split(' ') ??
        ['0', '0', '100', '100'];
    final width = double.tryParse(viewBox[2]) ?? 100;

    svgElement.attributes.add(
      xml.XmlAttribute(
        xml.XmlName('transform'),
        'translate($width,0) scale(-1,1)',
      ),
    );

    return doc.toXmlString(pretty: true);
  }

  /// Applies rotation to the SVG
  String _applyRotate(String svg, int degrees) {
    final doc = xml.XmlDocument.parse(svg);
    final svgElement = doc.findElements('svg').first;

    final viewBox =
        svgElement.getAttribute('viewBox')?.split(' ') ??
        ['0', '0', '100', '100'];
    final width = double.tryParse(viewBox[2]) ?? 100;
    final height = double.tryParse(viewBox[3]) ?? 100;

    svgElement.attributes.add(
      xml.XmlAttribute(
        xml.XmlName('transform'),
        'rotate($degrees ${width / 2} ${height / 2})',
      ),
    );

    return doc.toXmlString(pretty: true);
  }

  /// Applies translation to the SVG
  String _applyTranslate(String svg, int x, int y) {
    final doc = xml.XmlDocument.parse(svg);
    final svgElement = doc.findElements('svg').first;

    svgElement.attributes.add(
      xml.XmlAttribute(xml.XmlName('transform'), 'translate($x, $y)'),
    );

    return doc.toXmlString(pretty: true);
  }

  /// Applies clipping to the SVG
  String _applyClip(String svg, int radius) {
    final doc = xml.XmlDocument.parse(svg);
    final svgElement = doc.findElements('svg').first;

    final viewBox =
        svgElement.getAttribute('viewBox')?.split(' ') ??
        ['0', '0', '100', '100'];
    final width = double.tryParse(viewBox[2]) ?? 100;
    final height = double.tryParse(viewBox[3]) ?? 100;

    // Create a clip path
    final clipPathId = 'clip-${DateTime.now().millisecondsSinceEpoch}';
    final clipPath = SvgBuilder('clipPath')
      ..addAttribute('id', clipPathId)
      ..addChild(
        SvgBuilder.rect(
          width: width,
          height: height,
          rx: radius.toDouble(),
          ry: radius.toDouble(),
        ),
      ).build();

    // Add the clip path to the SVG
    final defs = xml.XmlDocument.parse('<defs>$clipPath</defs>');
    svgElement.children.insert(0, defs.firstChild!);

    // Apply the clip path to the SVG
    svgElement.attributes.add(
      xml.XmlAttribute(xml.XmlName('clip-path'), 'url(#$clipPathId)'),
    );

    return doc.toXmlString(pretty: true);
  }
}
