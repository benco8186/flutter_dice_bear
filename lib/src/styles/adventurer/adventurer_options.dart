import 'package:flutter_dice_bear/src/models/options.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/adventurer_assets.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/components/base.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/components/earrings.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/components/eyebrows.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/components/eyes.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/components/features.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/components/glasses.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/components/hair.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/components/mouth.dart';

/// Configuration options for the Adventurer avatar style.
///
/// This class allows customization of various visual aspects of the Adventurer avatars,
/// including colors, features, and the probability of certain elements appearing.
class AdventurerOptions extends AvatarOptions {
  /// Available base styles for the avatar.
  late final List<String> base;

  /// Available skin colors in hexadecimal format (e.g., ['#f0d9b5', '#d2a679']).
  final List<String> skinColor;

  /// Available hair colors in hexadecimal format.
  final List<String> hairColor;

  /// Available eye styles.
  late final List<String> eyes;

  /// Available eyebrow styles.
  late final List<String> eyebrows;

  /// Available mouth styles.
  late final List<String> mouth;

  /// Available hair styles.
  late final List<String> hair;

  /// Available glasses styles.
  late final List<String> glasses;

  /// Available earring styles.
  late final List<String> earrings;

  /// Available facial features.
  late final List<String> features;

  /// Probability (0-100) of glasses appearing on the avatar.
  final int glassesProbability;

  /// Probability (0-100) of facial features appearing on the avatar.
  final int featuresProbability;

  /// Probability (0-100) of hair appearing on the avatar.
  ///
  /// Defaults to 100 (100% chance of having hair).
  final int hairProbability;

  /// Probability (0-100) of earrings appearing on the avatar.
  ///
  /// Defaults to 10 (10% chance of having earrings).
  final int earringsProbability;

  /// Creates a new instance of [AdventurerOptions] with the given parameters.
  ///
  /// All parameters are optional with sensible defaults. The [seed] parameter is
  /// required to ensure consistent avatar generation.
  ///
  /// Example:
  /// ```dart
  /// final options = AdventurerOptions(
  ///   seed: 'unique-seed',
  ///   skinColor: ['#f0d9b5', '#d2a679'],
  ///   hairColor: ['#000000', '#663300'],
  ///   glassesProbability: 30, // 30% chance of having glasses
  /// );
  /// ```
  AdventurerOptions({
    List<String>? base,
    this.skinColor = AdventurerAssets.defaultSkinColors,
    this.hairColor = AdventurerAssets.defaultHairColors,
    List<String>? eyes,
    List<String>? eyebrows,
    List<String>? mouth,
    List<String>? hair,
    List<String>? glasses,
    List<String>? earrings,
    List<String>? features,
    this.glassesProbability = 10, // 10% chance by default
    this.featuresProbability = 5, // 5% chance by default
    this.hairProbability = 100, // 100% chance by default
    this.earringsProbability = 10, // 10% chance by default
    required super.seed,
    super.size,
    super.scale,
    super.flip = false,
    super.rotate,
    super.backgroundColor,
    super.backgroundType,
    super.backgroundRotation,
    super.translateX,
    super.translateY,
    super.radius,
    super.clip,
    super.randomizeIds = false,
  }) : super() {
    this.base = base ?? BaseComponents.availableVariants;
    this.eyes = eyes ?? EyeComponents.availableVariants;
    this.eyebrows = eyebrows ?? EyebrowComponents.availableVariants;
    this.glasses = glasses ?? GlasseComponents.availableVariants;
    this.mouth = mouth ?? MouthComponents.availableVariants;
    this.hair = hair ?? HairComponents.availableVariants;
    this.earrings = earrings ?? EarringComponents.availableVariants;
    this.features = features ?? FeatureComponents.availableVariants;
  }

  @override
  AdventurerOptions copyWith({
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
    List<String>? base,
    List<String>? skinColor,
    List<String>? hairColor,
    List<String>? eyes,
    List<String>? eyebrows,
    List<String>? mouth,
    List<String>? hair,
    List<String>? glasses,
    List<String>? earrings,
    List<String>? features,
    int? glassesProbability,
    int? featuresProbability,
    int? hairProbability,
    int? earringsProbability,
  }) {
    return AdventurerOptions(
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
      base: base ?? this.base,
      skinColor: skinColor ?? this.skinColor,
      hairColor: hairColor ?? this.hairColor,
      eyes: eyes ?? this.eyes,
      eyebrows: eyebrows ?? this.eyebrows,
      mouth: mouth ?? this.mouth,
      hair: hair ?? this.hair,
      glasses: glasses ?? this.glasses,
      earrings: earrings ?? this.earrings,
      features: features ?? this.features,
      glassesProbability: glassesProbability ?? this.glassesProbability,
      featuresProbability: featuresProbability ?? this.featuresProbability,
      hairProbability: hairProbability ?? this.hairProbability,
      earringsProbability: earringsProbability ?? this.earringsProbability,
    );
  }

  @override
  AdventurerOptions merge(AdventurerOptions? other) {
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
      base: other.base,
      skinColor: other.skinColor,
      hairColor: other.hairColor,
      eyes: other.eyes,
      eyebrows: other.eyebrows,
      mouth: other.mouth,
      hair: other.hair,
      glasses: other.glasses,
      earrings: other.earrings,
      features: other.features,
      glassesProbability: other.glassesProbability,
      featuresProbability: other.featuresProbability,
      hairProbability: other.hairProbability,
      earringsProbability: other.earringsProbability,
    );
  }
}
