import 'package:flutter_dice_bear/models/avatar_style.dart';
import 'package:flutter_dice_bear/core/prng.dart';
import 'package:flutter_dice_bear/models/style_create_result.dart';
import 'package:flutter_dice_bear/models/style_license.dart';
import 'package:flutter_dice_bear/models/style_meta.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_options.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_component_factory.dart';
import 'package:flutter_dice_bear/utils/extensions.dart';

/// Classe principale du style Adventurer
class AdventurerStyle extends AvatarStyle {
  static const invisibleEarringsHair = [
    'long01',
    'long04',
    'long05',
    'long06',
    'long20',
    'long22',
    'long24',
    'long26',
  ];

  static const StyleMeta _meta = StyleMeta(
    title: "Adventurer",
    creator: "Lisa Wischofsky",
    source: "https://www.figma.com/community/file/1184595184137881796",
    homepage: "https://www.instagram.com/lischi_art/",
    license: StyleLicense(
      name: "CC BY 4.0",
      url: "https://creativecommons.org/licenses/by/4.0/",
    ),
  );
  @override
  final AdventurerOptions options;
  AdventurerStyle({required this.options});

  @override
  StyleCreateResult create({required PRNG prng}) {
    final factory = AdventurerComponentFactory();
    final components = factory.getComponents(prng: prng, options: options);
    final colors = factory.getColors(prng: prng, options: options);
    if (components["hair"]?.name != null &&
        invisibleEarringsHair.contains(components["hair"]?.name)) {
      components["earrings"] = null;
    }
    final attr = StyleCreateResultAttributes(viewBox: '0 0 762 762');
    attr["fill"] = "none";
    attr["shape-rendering"] = "auto";
    return StyleCreateResult(
      attributes: attr,
      body:
          "${components["base"]?.value(components, colors) ?? ''}<g transform=\"translate(-161 -83)\">${components["eyes"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["eyebrows"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["mouth"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["features"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["glasses"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components["hair"]?.value(components, colors) ?? ''}</g><g transform=\"translate(-161 -83)\">${components['earrings']?.value(components, colors) ?? ''}</g>",
      extra: () => createExtraData(components, colors),
    );
  }

  @override
  StyleMeta get meta => _meta;
}
