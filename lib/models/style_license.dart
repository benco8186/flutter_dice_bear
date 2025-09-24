import 'package:flutter/foundation.dart';

@immutable
class StyleLicense {
  final String name;
  final String url;

  const StyleLicense({required this.name, required this.url});

  @override
  String toString() => 'License(name: $name, url: $url)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StyleLicense &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          url == other.url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
