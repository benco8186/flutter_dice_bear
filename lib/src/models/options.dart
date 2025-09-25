/// Base options for avatar generation
class AvatarOptions {
  /// The seed used to generate the avatar. The same seed will always produce
  /// the same avatar.
  final String seed;

  /// The size of the avatar in pixels.
  final double? size;

  /// The scale of the avatar as a percentage (0-100).
  final double? scale;

  /// Whether to flip the avatar horizontally.
  final bool flip;

  /// The rotation of the avatar in degrees.
  final double? rotate;

  /// The background color(s) of the avatar.
  final List<String>? backgroundColor;

  /// The type of background (e.g., 'solid', 'gradient').
  final List<String>? backgroundType;

  /// The rotation of the background in degrees.
  final List<int>? backgroundRotation;

  /// The horizontal translation of the avatar.
  final double? translateX;

  /// The vertical translation of the avatar.
  final double? translateY;

  /// The border radius of the avatar.
  final double? radius;

  /// Whether to clip the avatar to a circle.
  final bool? clip;

  /// Whether to randomize the IDs used in the SVG.
  final bool randomizeIds;

  /// Creates a new [AvatarOptions] instance.
  const AvatarOptions({
    required this.seed,
    this.size,
    this.scale,
    this.flip = false,
    this.rotate,
    this.backgroundColor,
    this.backgroundType,
    this.backgroundRotation,
    this.translateX,
    this.translateY,
    this.radius,
    this.clip,
    this.randomizeIds = false,
  });

  /// Creates a copy of this [AvatarOptions] with the given fields replaced
  /// with the new values.
  AvatarOptions copyWith({
    String? seed,
    double? size,
    double? scale,
    bool? flip,
    double? rotate,
    List<String>? backgroundColor,
    List<String>? backgroundType,
    List<int>? backgroundRotation,
    double? translateX,
    double? translateY,
    double? radius,
    bool? clip,
    bool? randomizeIds,
  }) {
    return AvatarOptions(
      seed: seed ?? this.seed,
      size: size ?? this.size,
      scale: scale ?? this.scale,
      flip: flip ?? this.flip,
      rotate: rotate ?? this.rotate,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundType: backgroundType ?? this.backgroundType,
      backgroundRotation: backgroundRotation ?? this.backgroundRotation,
      translateX: translateX ?? this.translateX,
      translateY: translateY ?? this.translateY,
      radius: radius ?? this.radius,
      clip: clip ?? this.clip,
      randomizeIds: randomizeIds ?? this.randomizeIds,
    );
  }

  /// Merges the given options with this one, with the given options
  /// taking precedence.
  AvatarOptions merge(covariant AvatarOptions? other) {
    if (other == null) return this;

    return copyWith(
      seed: other.seed,
      size: other.size,
      scale: other.scale,
      flip: other.flip,
      rotate: other.rotate,
      backgroundColor: other.backgroundColor,
      backgroundType: other.backgroundType,
      backgroundRotation: other.backgroundRotation,
      translateX: other.translateX,
      translateY: other.translateY,
      radius: other.radius,
      clip: other.clip,
      randomizeIds: other.randomizeIds,
    );
  }
}
