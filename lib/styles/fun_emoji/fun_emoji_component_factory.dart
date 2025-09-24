import 'package:flutter_dice_bear/core/prng.dart';
import 'package:flutter_dice_bear/models/component.dart';
import 'package:flutter_dice_bear/models/component_factory.dart';
import 'package:flutter_dice_bear/models/pick_component_props.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_options.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/fun_emoji_assets.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/fun_emoji_options.dart';

class FunEmojiComponentFactory extends ComponentFactory {
  @override
  ComponentPickCollection getComponents({
    required PRNG prng,
    required FunEmojiOptions options,
  }) {
    return {
      'mouth': pickComponent(
        PickComponentProps(prng: prng, group: 'mouth', values: options.mouth),
      ),

      'eyes': pickComponent(
        PickComponentProps(prng: prng, group: 'eyes', values: options.eyes),
      ),
    };
  }

  @override
  ComponentGroupCollection get componentCollection => FunEmojiAssets.assets;

  @override
  Map<String, String> getColors({
    required PRNG prng,
    required AdventurerOptions options,
  }) {
    return {};
  }
}
