import 'package:flutter_dice_bear/image_providers/svg_provider.dart';
import 'package:flutter_dice_bear/models/avatar_result.dart';

class DiceBearProvider extends SvgProvider {
  final AvatarResult avatarResult;

  DiceBearProvider({
    required this.avatarResult,
    super.size,
    super.scale,
    super.color,
    super.svgGetter,
  }) : super(avatarResult.svg);
}
