/// Represents the result of an avatar generation
class AvatarResult {
  /// The SVG string of the generated avatar
  final String svg;

  /// Additional metadata about the generated avatar
  final Map<String, dynamic> extra;

  /// Creates a new AvatarResult
  const AvatarResult({required this.svg, this.extra = const {}});

  /// Returns the SVG as a data URI that can be used in an <img> tag
  String toDataUri() {
    return 'data:image/svg+xml;utf8,${Uri.encodeComponent(svg)}';
  }

  /// Returns the raw SVG string
  String toSvgString() => svg;

  @override
  String toString() => svg;

  /// Creates a JSON representation of the avatar result
  Map<String, dynamic> toJson() {
    return {'svg': svg, 'extra': extra};
  }
}
