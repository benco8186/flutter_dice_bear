import 'package:flutter_dice_bear/src/models/avatar_style.dart';
import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/models/style_create_result.dart';
import 'package:flutter_dice_bear/src/models/style_license.dart';
import 'package:flutter_dice_bear/src/models/style_meta.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/adventurer_options.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/adventurer_component_factory.dart';
import 'package:flutter_dice_bear/src/utils/extensions.dart';

/// A style that generates avatar in the "Adventurer" theme.
///
/// This style creates playful and colorful avatars with various customization options
/// like different hair styles, eye shapes, and accessories.
///
/// Example:
/// ```dart
/// final style = AdventurerStyle(
///   options: AdventurerOptions(
///     seed: 'unique-seed',
///     backgroundColor: ['#ff9900'],
///     // other options...
///   ),
/// );
/// ```
class AdventurerStyle extends AvatarStyle {
  /// List of hair styles that should hide earrings when selected
  /// to prevent visual clipping or overlapping.
  static const invisibleEarringsHair = [
    'long01',
    'long04',
    'long05',
    'long06',
    'long20',
    'long22',
    'long24',
    'long26',
  ];

  /// Metadata about the Adventurer style including author, license, and source.
  static const StyleMeta _meta = StyleMeta(
    title: "Adventurer",
    creator: "Lisa Wischofsky",
    source: "https://www.figma.com/community/file/1184595184137881796",
    homepage: "https://www.instagram.com/lischi_art/",
    license: StyleLicense(
      name: "CC BY 4.0",
      url: "https://creativecommons.org/licenses/by/4.0/",
    ),
  );

  /// The configuration options for this avatar style.
  ///
  /// These options control the appearance and behavior of the generated avatars,
  /// including colors, features, and the probability of certain elements appearing.
  @override
  final AdventurerOptions options;

  /// Creates an instance of the Adventurer style with the given options.
  ///
  /// The [options] parameter is required and must be an instance of [AdventurerOptions].
  ///
  /// Example:
  /// ```dart
  /// final style = AdventurerStyle(
  ///   options: AdventurerOptions(
  ///     seed: 'unique-seed',
  ///     skinColor: ['#f0d9b5', '#d2a679'],
  ///     hairColor: ['#000000', '#663300'],
  ///   ),
  /// );
  /// ```
  AdventurerStyle({required this.options});

  /// Generates the avatar based on the current options and PRNG state.
  ///
  /// This method creates the SVG representation of the avatar by:
  /// 1. Creating a component factory for the Adventurer style
  /// 2. Generating the components and colors based on the PRNG and options
  /// 3. Applying any style-specific rules (like hiding earrings with certain hair styles)
  /// 4. Composing the final SVG string
  ///
  /// The [prng] parameter is a pseudo-random number generator that ensures
  /// consistent avatar generation based on the provided seed.
  ///
  /// Returns a [StyleCreateResult] containing:
  /// - The generated SVG as a string
  /// - SVG attributes for proper rendering
  /// - Additional metadata about the generated avatar
  ///
  /// Example:
  /// ```dart
  /// final prng = PRNG('seed-value');
  /// final result = style.create(prng: prng);
  /// final svgString = '<svg ${result.attributes}>${result.body}</svg>';
  /// ```
  @override
  StyleCreateResult create({required PRNG prng}) {
    // Create component factory and generate components/colors
    final factory = AdventurerComponentFactory();
    final components = factory.getComponents(prng: prng, options: options);
    final colors = factory.getColors(prng: prng, options: options);

    // Hide earrings for certain hair styles to prevent visual issues
    if (components["hair"]?.name != null &&
        invisibleEarringsHair.contains(components["hair"]?.name)) {
      components["earrings"] = null;
    }

    // Set up SVG attributes for proper rendering
    final attr = StyleCreateResultAttributes(viewBox: '0 0 762 762');
    attr["fill"] = "none";
    attr["shape-rendering"] = "auto";

    // Compose the SVG body by layering all components in the correct z-order
    // Each component is wrapped in a group with a specific transform
    return StyleCreateResult(
      attributes: attr,
      body:
          "${components["base"]?.value(components, colors) ?? ''}<g transform=\"translate(-161 -83)\">${components["eyes"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["eyebrows"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["mouth"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["features"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["glasses"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["hair"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components['earrings']?.value(components, colors) ?? ''}</g>",
      extra: () => createExtraData(components, colors),
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
  /// This information should be displayed when using the avatars in your application
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
