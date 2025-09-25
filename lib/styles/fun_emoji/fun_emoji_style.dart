import 'package:flutter_dice_bear/core/prng.dart';
import 'package:flutter_dice_bear/models/avatar_style.dart';
import 'package:flutter_dice_bear/models/style_create_result.dart';
import 'package:flutter_dice_bear/models/style_license.dart';
import 'package:flutter_dice_bear/models/style_meta.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/fun_emoji_options.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/fun_emoji_component_factory.dart';
import 'package:flutter_dice_bear/utils/extensions.dart';

class FunEmojiStyle extends AvatarStyle {
  static const StyleMeta _meta = StyleMeta(
    title: "Fun Emoji Set",
    creator: "Davis Uche",
    source: "https://www.figma.com/community/file/968125295144990435",
    homepage: "https://www.instagram.com/davedirect3/",
    license: StyleLicense(
      name: "CC BY 4.0",
      url: "https://creativecommons.org/licenses/by/4.0/",
    ),
  );
  @override
  final FunEmojiOptions options;

  FunEmojiStyle({required this.options});

  @override
  StyleCreateResult create({required PRNG prng}) {
    final factory = FunEmojiComponentFactory();
    final components = factory.getComponents(prng: prng, options: options);
    factory.getColors(prng: prng, options: options);
    final attr = StyleCreateResultAttributes(viewBox: '0 0 200 200');
    attr["fill"] = "none";
    attr["shape-rendering"] = "auto";
    return StyleCreateResult(
      attributes: attr,
      body:
          '<g transform="matrix(1.5625 0 0 1.5625 37.5 110.94)">${components["mouth"]?.value(components, {}) ?? ''}</g><g transform="matrix(1.5625 0 0 1.5625 31.25 59.38)">${components["eyes"]?.value(components, {}) ?? ''}</g>',
      extra: () => createExtraData(components, {}),
    );
  }

  @override
  StyleMeta get meta => _meta;
}
