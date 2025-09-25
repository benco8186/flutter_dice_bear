import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/models/component.dart';
import 'package:flutter_dice_bear/src/models/component_factory.dart';
import 'package:flutter_dice_bear/src/models/pick_component_props.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/fun_emoji_assets.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/fun_emoji_options.dart';

class FunEmojiComponentFactory extends ComponentFactory {
  @override
  ComponentPickCollection getComponents({
    required PRNG prng,
    required FunEmojiOptions options,
  }) {
    final mouthComponent = pickComponent(
      PickComponentProps(prng: prng, group: 'mouth', values: options.mouth),
    );
    final eyeComponent = pickComponent(
      PickComponentProps(prng: prng, group: 'eyes', values: options.eyes),
    );

    return {'mouth': mouthComponent, 'eyes': eyeComponent};
  }

  @override
  ComponentGroupCollection get componentCollection => FunEmojiAssets.assets;

  @override
  Map<String, String> getColors({
    required PRNG prng,
    required FunEmojiOptions options,
  }) {
    return {};
  }
}
