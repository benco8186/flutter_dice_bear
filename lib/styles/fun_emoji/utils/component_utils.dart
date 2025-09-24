import 'package:flutter_dice_bear/core/prng.dart';
import 'package:flutter_dice_bear/models/component.dart';
import 'package:flutter_dice_bear/models/pick_component_props.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/fun_emoji_assets.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/models/fun_emoji_options.dart';

abstract class ComponentUtils {
  static ComponentPickCollection getComponents({
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

  static ComponentPick? pickComponent(PickComponentProps props) {
    final ComponentGroupCollection componentCollection = FunEmojiAssets.assets;

    final String? key = props.prng.pick(props.values);

    if (key != null &&
        componentCollection.containsKey(props.group) &&
        componentCollection[props.group]!.containsKey(key)) {
      return ComponentPick(
        name: key,
        value: componentCollection[props.group]![key]!,
      );
    } else {
      return null;
    }
  }
}
