import 'dart:async';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Get svg string.
typedef SvgStringGetter = Future<String?> Function(SvgProviderImageKey key);

class SvgProvider extends ImageProvider<SvgProviderImageKey> {
  /// Path to svg file or asset
  final String svg;

  /// Size in logical pixels to render.
  /// Useful for [DecorationImage].
  /// If not specified, will use size from [Image].
  /// If [Image] not specifies size too, will use default size 100x100.
  final Size? size;

  /// Color to tint the SVG
  final Color? color;

  /// Image scale.
  final double? scale;

  /// Get svg string.
  /// Override the default get method.
  /// When returning null, use the default method.
  final SvgStringGetter? svgGetter;

  /// Width and height can also be specified from [Image] constructor.
  /// Default size is 100x100 logical pixels.
  /// Different size can be specified in [Image] parameters
  const SvgProvider(
    this.svg, {
    this.size,
    this.scale,
    this.color,
    this.svgGetter,
  });

  @override
  Future<SvgProviderImageKey> obtainKey(ImageConfiguration configuration) {
    final Color color = this.color ?? Colors.transparent;
    final double scale = this.scale ?? configuration.devicePixelRatio ?? 1.0;
    final double logicWidth = size?.width ?? configuration.size?.width ?? 100;
    final double logicHeight =
        size?.height ?? configuration.size?.height ?? 100;

    return SynchronousFuture<SvgProviderImageKey>(
      SvgProviderImageKey(
        svg: svg,
        scale: scale,
        color: color,
        pixelWidth: (logicWidth * scale).round(),
        pixelHeight: (logicHeight * scale).round(),
        svgGetter: svgGetter,
      ),
    );
  }

  @override
  ImageStreamCompleter loadImage(
    SvgProviderImageKey key,
    ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(_loadAsync(key));
  }

  static Future<String> _getSvgString(SvgProviderImageKey key) async {
    if (key.svgGetter != null) {
      final rawSvg = await key.svgGetter!.call(key);
      if (rawSvg != null) {
        return rawSvg;
      }
    }
    return key.svg;
  }

  static Future<ImageInfo> _loadAsync(SvgProviderImageKey key) async {
    final String rawSvg = await _getSvgString(key);
    final pictureInfo = await vg.loadPicture(
      SvgStringLoader(rawSvg),
      null,
      clipViewbox: false,
    );
    final ui.Image image = await pictureInfo.picture.toImage(
      pictureInfo.size.width.round(),
      pictureInfo.size.height.round(),
    );

    return ImageInfo(image: image, scale: 1.0);
  }

  // Note: == and hashCode not overrided as changes in properties
  // (width, height and scale) are not observable from the here.
  // [SvgImageKey] instances will be compared instead.
  @override
  String toString() => '$runtimeType(${describeIdentity(svg)})';

  // Running on web with Colors.transparent may throws the exception `Expected a value of type 'SkDeletable', but got one of type 'Null'`.
  static Color getFilterColor(color) {
    if (kIsWeb && color == Colors.transparent) {
      return const Color(0x01ffffff);
    } else {
      return color ?? Colors.transparent;
    }
  }
}

@immutable
class SvgProviderImageKey {
  const SvgProviderImageKey({
    required this.svg,
    required this.pixelWidth,
    required this.pixelHeight,
    required this.scale,
    this.color,
    this.svgGetter,
  });

  /// svg asset.
  final String svg;

  /// Width in physical pixels.
  /// Used when raterizing.
  final int pixelWidth;

  /// Height in physical pixels.
  /// Used when raterizing.
  final int pixelHeight;

  /// Color to tint the SVG
  final Color? color;

  /// Used to calculate logical size from physical, i.e.
  /// logicalWidth = [pixelWidth] / [scale],
  /// logicalHeight = [pixelHeight] / [scale].
  /// Should be equal to [MediaQueryData.devicePixelRatio].
  final double scale;

  /// Svg string getter.
  final SvgStringGetter? svgGetter;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SvgProviderImageKey &&
        other.svg == svg &&
        other.pixelWidth == pixelWidth &&
        other.pixelHeight == pixelHeight &&
        other.scale == scale &&
        other.svgGetter == svgGetter;
  }

  @override
  int get hashCode =>
      Object.hash(svg, pixelWidth, pixelHeight, scale, svgGetter);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'SvgProviderImageKey')}'
      '(svg: "$svg", pixelWidth: $pixelWidth, pixelHeight: $pixelHeight, scale: $scale)';
}
