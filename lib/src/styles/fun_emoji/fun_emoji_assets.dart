import 'package:flutter_dice_bear/src/models/component.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/components/eyes.dart';
import 'package:flutter_dice_bear/src/styles/fun_emoji/components/mouth.dart';

abstract class FunEmojiAssets {
  static const List<String> defaultBackgroundColor = [
    'fcbc34',
    'd84be5',
    'd9915b',
    'f6d594',
    '059ff2',
    '71cf62',
  ];
  static const Map<String, ComponentGroup> assets = {
    "mouth": MouthComponents.variants,
    "eyes": EyeComponents.variants,
  };
}
