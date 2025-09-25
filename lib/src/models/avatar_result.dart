class AvatarResult {
  final String svg;
  final Map<String, dynamic> extra;
  const AvatarResult({required this.svg, this.extra = const {}});

  String toDataUri() {
    return 'data:image/svg+xml;utf8,${Uri.encodeComponent(svg)}';
  }

  Map<String, dynamic> toJson() {
    return {'svg': svg, 'extra': extra};
  }
}
