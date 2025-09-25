// Fichier contenant les constantes des assets SVG pour le style Adventurer

import 'package:flutter_dice_bear/models/component.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/base.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/earrings.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/eyebrows.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/eyes.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/features.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/glasses.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/hair.dart';
import 'package:flutter_dice_bear/styles/adventurer/components/mouth.dart';

class AdventurerAssets {
  static const Map<String, ComponentGroup> assets = {
    "base": BaseComponents.variants,
    "earrings": EarringComponents.variants,
    "eyebrows": EyebrowComponents.variants,
    "eyes": EyeComponents.variants,
    "features": FeatureComponents.variants,
    "glasses": GlasseComponents.variants,
    "hair": HairComponents.variants,
    "mouth": MouthComponents.variants,
  };
  static const List<String> defaultSkinColors = [
    'f2d3b1',
    'ecad80',
    '9e5622',
    '763900',
  ];
  static const List<String> defaultHairColors = [
    'ac6511',
    'cb6820',
    'ab2a18',
    'e5d7a3',
    'b9a05f',
    '796a45',
    '6a4e35',
    '562306',
    '0e0e0e',
    'afafaf',
    '3eac2c',
    '85c2c6',
    'dba3be',
    '592454',
  ];
}
