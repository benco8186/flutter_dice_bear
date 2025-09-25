import 'package:flutter/material.dart';
import 'package:flutter_dice_bear/src/core/avatar_generator.dart';
import 'package:flutter_dice_bear/src/models/avatar_style.dart';
import 'package:flutter_dice_bear/src/models/avatar_result.dart';
import 'package:flutter_svg/svg.dart';

/// A widget that displays a customizable DiceBear avatar.
/// 
/// This widget generates and renders an avatar based on the provided [style].
/// It handles the rendering of the SVG and provides a loading placeholder.
///
/// Example:
/// ```dart
/// DiceBearWidget(
///   style: const AdventurerStyle(
///     options: AdventurerOptions(seed: 'custom-seed'),
///   ),
///   width: 200,
///   height: 200,
///   fit: BoxFit.contain,
/// )
/// ```
class DiceBearWidget extends StatelessWidget {
  /// The style configuration for the avatar.
  /// This includes the avatar style (e.g., Adventurer, Fun Emoji) and its options.
  final AvatarStyle style;

  /// The width of the avatar. If null, the avatar will take the available width.
  final double? width;

  /// The height of the avatar. If null, the avatar will take the available height.
  final double? height;

  /// How the avatar should be inscribed into the space allocated during layout.
  /// Defaults to [BoxFit.contain].
  final BoxFit fit;

  /// A builder that creates a widget to display while the avatar is loading.
  /// If null, a default loading indicator will be shown.
  final WidgetBuilder? placeholderBuilder;

  /// Creates a widget that displays a DiceBear avatar.
  const DiceBearWidget({
    super.key,
    required this.style,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      _createAvatar().svg,
      key: key,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: placeholderBuilder ?? _defaultPlaceholderBuilder,
    );
  }

  /// Default placeholder widget shown while the avatar is loading.
  /// Displays a centered circular progress indicator.
  Widget _defaultPlaceholderBuilder(BuildContext context) => SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );

  /// Generates the avatar using the current style configuration.
  /// 
  /// This method creates a new [AvatarGenerator] with the current style
  /// and generates the avatar SVG data.
  /// 
  /// Returns an [AvatarResult] containing the generated SVG data and metadata.
  AvatarResult _createAvatar() {
    final generator = AvatarGenerator(style: style);
    return generator.generate();
  }
}
