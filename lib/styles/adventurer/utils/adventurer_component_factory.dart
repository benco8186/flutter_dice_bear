import 'package:flutter_dice_bear/core/prng.dart';
import 'package:flutter_dice_bear/models/component.dart';
import 'package:flutter_dice_bear/models/pick_component_props.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_assets.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_options.dart';
import 'package:flutter_dice_bear/models/component_factory.dart';
import 'package:flutter_dice_bear/utils/functions.dart';

class AdventurerComponentFactory extends ComponentFactory {
  @override
  ComponentGroupCollection get componentCollection => AdventurerAssets.assets;

  @override
  Map<String, String> getColors({
    required PRNG prng,
    required AdventurerOptions options,
  }) {
    return {
      'skin': convertColor(prng.pick(options.skinColor, 'transparent')!),
      'hair': convertColor(prng.pick(options.hairColor, 'transparent')!),
    };
  }

  @override
  ComponentPickCollection getComponents({
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
}
