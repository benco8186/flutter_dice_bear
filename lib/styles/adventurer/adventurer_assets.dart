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
    "763900",
    "9e5622",
    "ecad80",
    "f2d3b1",
  ];
  static const List<String> defaultHairColors = [
    "0e0e0e",
    "3eac2c",
    "562306",
    "592454",
    "6a4e35",
    "796a45",
    "85c2c6",
    "ab2a18",
    "ac6511",
    "afafaf",
    "b9a05f",
    "cb6820",
    "dba3be",
    "e5d7a3",
  ];
}
