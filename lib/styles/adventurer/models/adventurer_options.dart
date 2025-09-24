import 'package:flutter_dice_bear/models/options.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_assets.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/base.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/earrings.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/eyebrows.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/eyes.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/features.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/glasses.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/hair.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/mouth.dart';

class AdventurerOptions extends AvatarOptions {
  late final List<String> base;
  final List<String> skinColor;
  final List<String> hairColor;
  late final List<String> eyes;
  late final List<String> eyebrows;
  late final List<String> mouth;
  late final List<String> hair;
  late final List<String> glasses;
  late final List<String> earrings;
  late final List<String> features;
  final int glassesProbability;
  final int featuresProbability;
  final int hairProbability;
  final int earringsProbability;

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
    this.glassesProbability = 10,
    this.featuresProbability = 5,
    this.hairProbability = 100,
    this.earringsProbability = 10,
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
  }) {
    this.base = base ?? BaseComponents.availableVariants;
    this.eyes = eyes ?? EyeComponents.availableVariants;
    this.eyebrows = eyebrows ?? EyebrowComponents.availableVariants;
    this.mouth = mouth ?? MouthComponents.availableVariants;
    this.hair = hair ?? HairComponents.availableVariants;
    this.glasses = glasses ?? GlasseComponents.availableVariants;
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
