import 'package:flutter_dice_bear/src/image_providers/svg_provider.dart';
import 'package:flutter_dice_bear/src/models/avatar_result.dart';

/// A provider that serves a DiceBear avatar as an image.
///
/// This class extends [SvgProvider] to provide SVG-based avatar images
/// that can be used with Flutter's [Image] widget.
///
/// Example:
/// ```dart
/// // First generate an avatar result
/// final avatarResult = AvatarGenerator(
///   style: const AdventurerStyle(
///     options: AdventurerOptions(seed: 'custom-seed'),
///   ),
/// ).generate();
///
/// // Create a provider
/// final provider = DiceBearProvider(
///   avatarResult: avatarResult,
///   size: 200,
///   color: Colors.blue,
/// );
///
/// // Use with an Image widget
/// Image(image: provider);
/// ```
class DiceBearProvider extends SvgProvider {
  /// The avatar result containing the SVG data and metadata.
  final AvatarResult avatarResult;

  /// Creates an image provider for a DiceBear avatar.
  ///
  /// The [avatarResult] parameter is required and contains the SVG data
  /// and metadata for the avatar.
  ///
  /// Additional parameters are passed to the parent [SvgProvider]:
  /// - [size] defines the width and height of the rendered image.
  /// - [scale] scales the image relative to the [size].
  /// - [color] is the color to apply to the SVG.
  /// - [svgGetter] is an optional callback to asynchronously load the SVG data.
  DiceBearProvider({
    required this.avatarResult,
    super.size,
    super.scale,
    super.color,
    super.svgGetter,
  }) : super(avatarResult.svg);
}
