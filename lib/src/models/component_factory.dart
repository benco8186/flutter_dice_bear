import 'package:flutter_dice_bear/src/core/prng.dart';
import 'package:flutter_dice_bear/src/models/component.dart';
import 'package:flutter_dice_bear/src/models/options.dart';
import 'package:flutter_dice_bear/src/models/pick_component_props.dart';

abstract class ComponentFactory {
  ComponentGroupCollection get componentCollection;
  Map<String, String> getColors({
    required PRNG prng,
    required covariant AvatarOptions options,
  });

  ComponentPickCollection getComponents({
    required PRNG prng,
    required covariant AvatarOptions options,
  });
  ComponentPick? pickComponent(PickComponentProps props) {
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
