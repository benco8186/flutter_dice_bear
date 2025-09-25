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
  DiceBearProvider({required this.avatarResult}) : super(avatarResult.svg);
}
