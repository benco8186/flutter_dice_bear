import 'package:flutter/material.dart';
import 'package:flutter_dice_bear/src/models/style_license.dart';

@immutable
class StyleMeta {
  final String? title;
  final String? source;
  final String? creator;
  final String? homepage;
  final StyleLicense? license;

  const StyleMeta({
    this.title,
    this.source,
    this.creator,
    this.homepage,
    this.license,
  });

  // Factory constructor pour créer depuis une Map (utile pour la désérialisation JSON)
  factory StyleMeta.fromMap(Map<String, dynamic> map) {
    return StyleMeta(
      title: map['title'],
      source: map['source'],
      creator: map['creator'],
      homepage: map['homepage'],
      license: map['license'] != null
          ? StyleLicense(
              name: map['license']['name'] ?? '',
              url: map['license']['url'] ?? '',
            )
          : null,
    );
  }

  // Méthode pour convertir en Map (utile pour la sérialisation JSON)
  Map<String, dynamic> toMap() {
    return {
      if (title != null) 'title': title,
      if (source != null) 'source': source,
      if (creator != null) 'creator': creator,
      if (homepage != null) 'homepage': homepage,
      if (license != null)
        'license': {'name': license!.name, 'url': license!.url},
    };
  }

  // Méthode copyWith pour créer des copies modifiées
  StyleMeta copyWith({
    String? title,
    String? source,
    String? creator,
    String? homepage,
    StyleLicense? license,
  }) {
    return StyleMeta(
      title: title ?? this.title,
      source: source ?? this.source,
      creator: creator ?? this.creator,
      homepage: homepage ?? this.homepage,
      license: license ?? this.license,
    );
  }

  @override
  String toString() {
    return 'StyleMeta(title: $title, source: $source, creator: $creator, homepage: $homepage, license: $license)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StyleMeta &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          source == other.source &&
          creator == other.creator &&
          homepage == other.homepage &&
          license == other.license;

  @override
  int get hashCode =>
      title.hashCode ^
      source.hashCode ^
      creator.hashCode ^
      homepage.hashCode ^
      license.hashCode;
}

// Exemple d'utilisation
