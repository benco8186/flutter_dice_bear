import 'package:flutter_dice_bear/src/core/prng.dart';

class PickComponentProps {
  final PRNG prng;
  final String group;
  final List<String> values;

  PickComponentProps({
    required this.prng,
    required this.group,
    this.values = const [],
  });
}
