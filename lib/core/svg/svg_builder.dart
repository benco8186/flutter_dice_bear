/// A builder class for creating SVG elements with attributes
class SvgBuilder {
  final Map<String, String> _attributes = {};
  final List<String> _children = [];
  final String _tagName;

  /// Creates a new SvgBuilder with the given tag name
  SvgBuilder(this._tagName);

  /// Adds an attribute to the SVG element
  SvgBuilder addAttribute(String name, String value) {
    if (value.isNotEmpty) {
      _attributes[name] = _escapeAttribute(value);
    }
    return this;
  }

  /// Adds multiple attributes to the SVG element
  SvgBuilder addAttributes(Map<String, String> attributes) {
    for (final entry in attributes.entries) {
      if (entry.value.isNotEmpty) {
        _attributes[entry.key] = _escapeAttribute(entry.value);
      }
    }
    return this;
  }

  /// Adds a child element to the SVG element
  SvgBuilder addChild(String child) {
    _children.add(child);
    return this;
  }

  /// Adds multiple child elements to the SVG element
  SvgBuilder addChildren(List<String> children) {
    _children.addAll(children);
    return this;
  }

  /// Builds the SVG element as a string
  String build() {
    final buffer = StringBuffer();
    buffer.write('<$_tagName');

    // Add attributes
    for (final entry in _attributes.entries) {
      buffer.write(' ${entry.key}="${entry.value}"');
    }

    if (_children.isEmpty) {
      buffer.write(' />');
    } else {
      buffer.write('>');
      buffer.write(_children.join(''));
      buffer.write('</$_tagName>');
    }

    return buffer.toString();
  }

  /// Creates an SVG group with the given children and attributes
  static String group(
    String children, {
    Map<String, String> attributes = const {},
  }) {
    final builder = SvgBuilder('g')
      ..addAttributes(attributes)
      ..addChild(children);
    return builder.build();
  }

  /// Creates an SVG path with the given data and attributes
  static String path(
    String pathData, {
    Map<String, String> attributes = const {},
  }) {
    final builder = SvgBuilder('path')
      ..addAttribute('d', pathData)
      ..addAttributes(attributes);
    return builder.build();
  }

  /// Creates an SVG rectangle with the given dimensions and attributes
  static String rect({
    required double width,
    required double height,
    double x = 0,
    double y = 0,
    double? rx,
    double? ry,
    Map<String, String> attributes = const {},
  }) {
    final builder = SvgBuilder('rect')
      ..addAttribute('x', x.toStringAsFixed(2))
      ..addAttribute('y', y.toStringAsFixed(2))
      ..addAttribute('width', width.toStringAsFixed(2))
      ..addAttribute('height', height.toStringAsFixed(2))
      ..addAttributes(attributes);

    if (rx != null) {
      builder.addAttribute('rx', rx.toStringAsFixed(2));
    }
    if (ry != null) {
      builder.addAttribute('ry', ry.toStringAsFixed(2));
    }

    return builder.build();
  }

  /// Creates an SVG circle with the given center, radius, and attributes
  static String circle({
    required double cx,
    required double cy,
    required double r,
    Map<String, String> attributes = const {},
  }) {
    final builder = SvgBuilder('circle')
      ..addAttribute('cx', cx.toStringAsFixed(2))
      ..addAttribute('cy', cy.toStringAsFixed(2))
      ..addAttribute('r', r.toStringAsFixed(2))
      ..addAttributes(attributes);
    return builder.build();
  }

  /// Creates an SVG linear gradient
  static String linearGradient({
    required String id,
    List<MapEntry<double, String>>? stops,
    double x1 = 0,
    double y1 = 0,
    double x2 = 100,
    double y2 = 0,
    String? gradientTransform,
    String? gradientUnits,
    Map<String, String> attributes = const {},
  }) {
    final builder = SvgBuilder('linearGradient')
      ..addAttribute('id', id)
      ..addAttribute('x1', '$x1%')
      ..addAttribute('y1', '$y1%')
      ..addAttribute('x2', '$x2%')
      ..addAttribute('y2', '$y2%')
      ..addAttributes(attributes);

    if (gradientTransform != null) {
      builder.addAttribute('gradientTransform', gradientTransform);
    }

    if (gradientUnits != null) {
      builder.addAttribute('gradientUnits', gradientUnits);
    }

    if (stops != null) {
      for (final stop in stops) {
        final stopBuilder = SvgBuilder('stop')
          ..addAttribute('offset', '${stop.key}%')
          ..addAttribute('stop-color', stop.value);

        builder.addChild(stopBuilder.build());
      }
    }

    return builder.build();
  }

  /// Adds an attribute conditionally
  SvgBuilder addAttributeIf(bool condition, String name, String value) {
    if (condition) {
      return addAttribute(name, value);
    }
    return this;
  }

  /// Escapes special characters in attribute values
  String _escapeAttribute(String value) {
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('"', '&quot;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');
  }
}
