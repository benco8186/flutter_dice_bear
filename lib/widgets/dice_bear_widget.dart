import 'package:flutter/material.dart';
import 'package:flutter_dice_bear/core/avatar_generator.dart';
import 'package:flutter_dice_bear/models/avatar_style.dart';
import 'package:flutter_dice_bear/models/avatar_result.dart';
import 'package:flutter_svg/svg.dart';

class DiceBearWidget extends StatelessWidget {
  final AvatarStyle style;
  final double? width;
  final double? height;
  final BoxFit fit;
  final WidgetBuilder? placeholderBuilder;
  const DiceBearWidget({
    super.key,
    required this.style,

    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      _createAvatar().svg,
      key: key,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder:
          placeholderBuilder ??
          (context) => SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
    );
  }

  AvatarResult _createAvatar() {
    final generator = AvatarGenerator(style: style);
    return generator.generate();
  }
}
