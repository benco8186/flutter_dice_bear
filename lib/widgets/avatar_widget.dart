import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_dice_bear/core/avatar_generator.dart';
import 'package:flutter_dice_bear/core/options.dart';
import 'package:flutter_dice_bear/core/prng.dart';
import 'package:flutter_dice_bear/styles/smiley/smiley_options.dart';
import 'package:flutter_dice_bear/styles/smiley/smiley_style.dart';
import 'package:flutter_svg/svg.dart';

class AvatarWidget extends StatefulWidget {
  /// The initial seed for the avatar
  final String seed;

  /// Called when the avatar is tapped
  final VoidCallback? onTap;

  /// The size of the avatar
  final double size;

  /// The options for the avatar
  final SmileyOptions options;

  const AvatarWidget({
    super.key,
    this.seed = 'default',
    this.onTap,
    this.size = 200.0,
    required this.options,
  });

  @override
  AvatarWidgetState createState() => AvatarWidgetState();
}

class AvatarWidgetState extends State<AvatarWidget> {
  late AvatarGenerator<SmileyOptions> _generator;
  late SmileyStyle _style;
  late PRNG _prng;
  late String _svgString;

  @override
  void initState() {
    super.initState();
    _style = SmileyStyle();
    _prng = PRNG(widget.seed);
    _generator = AvatarGenerator<SmileyOptions>(
      style: _style,
      defaultOptions: AvatarOptions(seed: widget.seed),
    );
    _svgString = _generator.generate(widget.options).toSvgString();
  }

  @override
  void didUpdateWidget(AvatarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      _svgString = _generator.generate(widget.options).toSvgString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convert SVG string to bytes
    final svgBytes = utf8.encode(_svgString);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: ClipOval(
          child: SvgPicture.string(
            _svgString,
            width: widget.size,
            height: widget.size,
            fit: BoxFit.contain,
            placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
