import 'package:flutter_dice_bear/src/models/options.dart';
import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/models/style_create_result.dart';
import 'package:flutter_dice_bear/src/models/style_meta.dart';

/// Base class for all avatar styles
abstract class AvatarStyle {
  /// The name of the style
  StyleMeta get meta;
  AvatarOptions get options;

  /// Creates the avatar components
  StyleCreateResult create({required PRNG prng});
}
