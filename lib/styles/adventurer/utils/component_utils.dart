import 'package:flutter_dice_bear/core/prng.dart';
import 'package:flutter_dice_bear/models/component.dart';
import 'package:flutter_dice_bear/models/pick_component_props.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_assets.dart';
import 'package:flutter_dice_bear/styles/adventurer/models/adventurer_options.dart';
import 'package:flutter_dice_bear/utils/functions.dart';

abstract class ComponentUtils {
  static Map<String, String> getColors({
    required PRNG prng,
    required AdventurerOptions options,
  }) {
    return {
      'skin': convertColor(prng.pick(options.skinColor, 'transparent')!),
      'hair': convertColor(prng.pick(options.hairColor, 'transparent')!),
    };
  }

  static ComponentPickCollection getComponents({
    required PRNG prng,
    required AdventurerOptions options,
  }) {
    return {
      'base': pickComponent(
        PickComponentProps(prng: prng, group: 'base', values: options.base),
      ),
      'eyes': pickComponent(
        PickComponentProps(prng: prng, group: 'eyes', values: options.eyes),
      ),
      'eyebrows': pickComponent(
        PickComponentProps(
          prng: prng,
          group: 'eyebrows',
          values: options.eyebrows,
        ),
      ),
      'mouth': pickComponent(
        PickComponentProps(prng: prng, group: 'mouth', values: options.mouth),
      ),
      'hair': prng.nextBool(options.hairProbability)
          ? pickComponent(
              PickComponentProps(
                prng: prng,
                group: 'hair',
                values: options.hair,
              ),
            )
          : null,

      'glasses': prng.nextBool(options.glassesProbability)
          ? pickComponent(
              PickComponentProps(
                prng: prng,
                group: 'glasses',
                values: options.glasses,
              ),
            )
          : null,
      'earrings': prng.nextBool(options.earringsProbability)
          ? pickComponent(
              PickComponentProps(
                prng: prng,
                group: 'earrings',
                values: options.earrings,
              ),
            )
          : null,
      'features': prng.nextBool(options.featuresProbability)
          ? pickComponent(
              PickComponentProps(
                prng: prng,
                group: 'features',
                values: options.features,
              ),
            )
          : null,
    };
  }

  static ComponentPick? pickComponent(PickComponentProps props) {
    final ComponentGroupCollection componentCollection =
        AdventurerAssets.assets;

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
