import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/models/component.dart';
import 'package:flutter_dice_bear/src/models/pick_component_props.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/adventurer_assets.dart';
import 'package:flutter_dice_bear/src/styles/adventurer/adventurer_options.dart';
import 'package:flutter_dice_bear/src/models/component_factory.dart';
import 'package:flutter_dice_bear/src/utils/functions.dart';

class AdventurerComponentFactory extends ComponentFactory {
  @override
  ComponentGroupCollection get componentCollection => AdventurerAssets.assets;

  @override
  Map<String, String> getColors({
    required PRNG prng,
    required AdventurerOptions options,
  }) {
    final skinColor = prng.pick(options.skinColor, 'transparent');
    final hairColor = prng.pick(options.hairColor, 'transparent');
    return {'skin': convertColor(skinColor!), 'hair': convertColor(hairColor!)};
  }

  @override
  ComponentPickCollection getComponents({
    required PRNG prng,
    required AdventurerOptions options,
  }) {
    final baseComponent = pickComponent(
      PickComponentProps(prng: prng, group: 'base', values: options.base),
    );
    final eyeComponent = pickComponent(
      PickComponentProps(prng: prng, group: 'eyes', values: options.eyes),
    );
    final eyebrowComponent = pickComponent(
      PickComponentProps(
        prng: prng,
        group: 'eyebrows',
        values: options.eyebrows,
      ),
    );
    final mouthComponent = pickComponent(
      PickComponentProps(prng: prng, group: 'mouth', values: options.mouth),
    );
    final featureComponent = pickComponent(
      PickComponentProps(
        prng: prng,
        group: 'features',
        values: options.features,
      ),
    );
    final glassesComponent = pickComponent(
      PickComponentProps(prng: prng, group: 'glasses', values: options.glasses),
    );
    final hearComponent = pickComponent(
      PickComponentProps(prng: prng, group: 'hair', values: options.hair),
    );
    final earringComponent = pickComponent(
      PickComponentProps(
        prng: prng,
        group: 'earrings',
        values: options.earrings,
      ),
    );
    return {
      'base': baseComponent,
      'eyes': eyeComponent,
      'eyebrows': eyebrowComponent,
      'mouth': mouthComponent,
      'features': prng.nextBool(options.featuresProbability)
          ? featureComponent
          : null,
      'glasses': prng.nextBool(options.glassesProbability)
          ? glassesComponent
          : null,
      'hair': prng.nextBool(options.hairProbability) ? hearComponent : null,

      'earrings': prng.nextBool(options.earringsProbability)
          ? earringComponent
          : null,
    };
  }
}
