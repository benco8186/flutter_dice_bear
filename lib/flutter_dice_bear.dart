library;
// A Flutter implementation of the DiceBear avatar generation library.
/// This package allows you to generate customizable avatars with different styles.
///
/// To get started, import the package and use the [DiceBearWidget] or [DiceBearProvider]
/// to display avatars in your Flutter application.
///
/// Example:
/// ```dart
/// import 'package:flutter_dice_bear/flutter_dice_bear.dart';
///
/// // Create and display an avatar
/// DiceBearWidget(
///   style: const AdventurerStyle(
///     options: AdventurerOptions(seed: 'custom-seed'),
///   ),
/// );
/// ```

// Core models and interfaces
export 'src/models/avatar_style.dart';
export 'src/models/options.dart';

// Style implementations
export 'src/styles/adventurer/adventurer_options.dart';
export 'src/styles/adventurer/adventurer_style.dart';
export 'src/styles/fun_emoji/fun_emoji_options.dart';
export 'src/styles/fun_emoji/fun_emoji_style.dart';

// Image providers and widgets
export 'src/image_providers/dice_bear_provider.dart';
export 'src/core/avatar_generator.dart';
export 'src/widgets/dice_bear_widget.dart';
