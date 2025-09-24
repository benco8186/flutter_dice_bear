import 'package:flutter_dice_bear/models/options.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/components/eyes.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/components/mouth.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/fun_emoji_assets.dart';

class FunEmojiOptions extends AvatarOptions {
  late final List<String> eyes;
  late final List<String> mouth;
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
