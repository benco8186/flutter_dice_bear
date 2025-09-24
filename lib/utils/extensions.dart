import 'package:flutter_dice_bear/models/component.dart';

extension MapMerge<K, V> on Map<K, V> {
  Map<K, V> merge(Map<K, V> other) {
    return {...this, ...other};
  }
}

Map<String, dynamic> createExtraData(
  Map<String, ComponentPick?> components,
  Map<String, String> colors,
) {
  final componentMap = components.map(
    (key, value) => MapEntry(key, value?.name),
  );

  final colorMap = colors.map((key, value) => MapEntry('${key}Color', value));

  return componentMap.merge(colorMap);
}
