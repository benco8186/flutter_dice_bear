/// Options for customizing the Smiley avatar style
class SmileyOptions {
  /// The size of the smiley face
  final double size;

  /// The primary color of the smiley face
  final String faceColor;

  /// The color of the eyes and mouth
  final String featureColor;

  /// Whether the smiley is happy (true) or sad (false)
  final bool isHappy;

  /// Whether to show glasses
  final bool hasGlasses;

  /// Creates a new SmileyOptions instance
  const SmileyOptions({
    this.size = 200.0,
    this.faceColor = '#FFD700', // Gold
    this.featureColor = '#000000', // Black
    this.isHappy = true,
    this.hasGlasses = false,
  });

  /// Creates a copy of these options with the given fields replaced
  SmileyOptions copyWith({
    double? size,
    String? faceColor,
    String? featureColor,
    bool? isHappy,
    bool? hasGlasses,
  }) {
    return SmileyOptions(
      size: size ?? this.size,
      faceColor: faceColor ?? this.faceColor,
      featureColor: featureColor ?? this.featureColor,
      isHappy: isHappy ?? this.isHappy,
      hasGlasses: hasGlasses ?? this.hasGlasses,
    );
  }
}
