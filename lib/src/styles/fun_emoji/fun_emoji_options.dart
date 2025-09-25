import 'package:flutter_dice_bear/src/models/options.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/components/eyes.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/components/mouth.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/fun_emoji_assets.dart';

/// Configuration options for the Fun Emoji avatar style.
///
/// This class allows customization of the Fun Emoji avatars,
/// including eye and mouth styles, colors, and other visual properties.
class FunEmojiOptions extends AvatarOptions {
  /// Available eye styles for the emoji.
  ///
  /// Each string represents a different eye style that can be applied to the emoji.
  /// If not specified, all available eye styles will be used.
  late final List<String> eyes;

  /// Available mouth styles for the emoji.
  ///
  /// Each string represents a different mouth style that can be applied to the emoji.
  /// If not specified, all available mouth styles will be used.
  late final List<String> mouth;
  /// Creates a new instance of [FunEmojiOptions] with the given parameters.
  ///
  /// The [seed] parameter is required to ensure consistent emoji generation.
  /// All other parameters are optional with sensible defaults.
  ///
  /// Example:
  /// ```dart
  /// final options = FunEmojiOptions(
  ///   seed: 'unique-seed',
  ///   eyes: ['happy', 'wink'],  // Only use these eye styles
  ///   backgroundColor: ['#FF5733'],  // Custom background color
  ///   size: 200,  // Set custom size
  /// );
  /// ```
  FunEmojiOptions({
    List<String>? eyes,
    List<String>? mouth,
    required super.seed,
    super.size,
    super.scale,
    super.flip = false,
    super.rotate,
    super.backgroundColor = FunEmojiAssets.defaultBackgroundColor,
    super.backgroundType,
    super.backgroundRotation,
    super.translateX,
    super.translateY,
    super.radius,
    super.clip,
    super.randomizeIds = false,
  }) {
    this.eyes = eyes ?? EyeComponents.availableVariants;
    this.mouth = mouth ?? MouthComponents.availableVariants;
  }
}
