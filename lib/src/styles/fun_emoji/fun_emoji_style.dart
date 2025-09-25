import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/models/avatar_style.dart';
import 'package:flutter_dice_bear/src/models/style_create_result.dart';
import 'package:flutter_dice_bear/src/models/style_license.dart';
import 'package:flutter_dice_bear/src/models/style_meta.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/fun_emoji_options.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/fun_emoji_component_factory.dart';
import 'package:flutter_dice_bear/src/utils/extensions.dart';

/// A style that generates avatar in the "Fun Emoji" theme.
///
/// This style creates expressive emoji-style avatars with various customization options
/// like different eye shapes, mouth expressions, and colors.
///
/// Example:
/// ```dart
/// final style = FunEmojiStyle(
///   options: FunEmojiOptions(
///     seed: 'unique-seed',
///     // other options...
///   ),
/// );
/// ```
class FunEmojiStyle extends AvatarStyle {
  /// Metadata about the Fun Emoji style including author, license, and source.
  static const StyleMeta _meta = StyleMeta(
    title: "Fun Emoji Set",
    creator: "Davis Uche",
    source: "https://www.figma.com/community/file/968125295144990435",
    homepage: "https://www.instagram.com/davedirect3/",
    license: StyleLicense(
      name: "CC BY 4.0",
      url: "https://creativecommons.org/licenses/by/4.0/",
    ),
  );

  /// The configuration options for this emoji style.
  ///
  /// These options control the appearance of the generated emoji avatars,
  /// including eye and mouth styles, colors, and other visual properties.
  @override
  final FunEmojiOptions options;

  /// Creates an instance of the Fun Emoji style with the given options.
  ///
  /// The [options] parameter is required and must be an instance of [FunEmojiOptions].
  ///
  /// Example:
  /// ```dart
  /// final style = FunEmojiStyle(
  ///   options: FunEmojiOptions(
  ///     seed: 'unique-seed',
  ///     eyes: ['happy', 'wink'],  // Only use these eye styles
  ///     mouth: ['smile', 'laugh'], // Only use these mouth styles
  ///     backgroundColor: ['#FF5733'],  // Custom background color
  ///   ),
  /// );
  /// ```
  FunEmojiStyle({required this.options});

  /// Generates the emoji avatar based on the current options and PRNG state.
  ///
  /// This method creates the SVG representation of the emoji by:
  /// 1. Creating a component factory for the Fun Emoji style
  /// 2. Generating the components based on the PRNG and options
  /// 3. Composing the final SVG string with proper positioning
  ///
  /// The [prng] parameter is a pseudo-random number generator that ensures
  /// consistent emoji generation based on the provided seed.
  ///
  /// Returns a [StyleCreateResult] containing:
  /// - The generated SVG as a string with properly positioned components
  /// - SVG attributes for proper rendering
  /// - Additional metadata about the generated emoji
  ///
  /// Example:
  /// ```dart
  /// final prng = PRNG('seed-value');
  /// final result = style.create(prng: prng);
  /// final svgString = '<svg ${result.attributes}>${result.body}</svg>';
  /// ```
  @override
  StyleCreateResult create({required PRNG prng}) {
    // Create component factory and generate components
    final factory = FunEmojiComponentFactory();
    final components = factory.getComponents(prng: prng, options: options);
    
    // Generate colors (stored in the factory)
    // The colors are applied directly to the components in the factory
    factory.getColors(prng: prng, options: options);
    
    // Set up SVG attributes for proper rendering
    final attr = StyleCreateResultAttributes(viewBox: '0 0 200 200');
    attr["fill"] = "none";
    attr["shape-rendering"] = "auto";
    
    // Compose the SVG body with positioned components
    // Each component is wrapped in a group with a specific transform
    // to position it correctly within the emoji face
    return StyleCreateResult(
      attributes: attr,
      body: 
          // Position and render the mouth component
          // The transform matrix scales and positions the mouth
          '<g transform="matrix(1.5625 0 0 1.5625 37.5 110.94)">'
          '${components["mouth"]?.value(components, {}) ?? ''}'
          '</g>'
          // Position and render the eyes component
          // The transform matrix scales and positions the eyes
          '<g transform="matrix(1.5625 0 0 1.5625 31.25 59.38)">'
          '${components["eyes"]?.value(components, {}) ?? ''}'
          '</g>',
      extra: () => createExtraData(components, {}),
    );
  }

  /// Gets the metadata for this style.
  ///
  /// The metadata includes important attribution information such as:
  /// - The style's title and creator
  /// - Source of the original artwork
  /// - License information and attribution requirements
  /// - Links to the creator's website
  ///
  /// This information should be displayed when using the emojis in your application
  /// to comply with the license terms.
  ///
  /// Example:
  /// ```dart
  /// final meta = style.meta;
  /// print('Style: ${meta.title} by ${meta.creator}');
  /// print('License: ${meta.license.name} (${meta.license.url})');
  /// ```
  @override
  StyleMeta get meta => _meta;
}
