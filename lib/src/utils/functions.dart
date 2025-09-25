import 'package:flutter_dice_bear/src/models/style_create_result.dart';

String escapeXml(String input) {
  return input
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&#x27;');
}

String createAttrString(StyleCreateResult result) {
  final attributes = {
    "xmlns": "http://www.w3.org/2000/svg",
    ...result.attributes,
  };

  return attributes.entries
      .map((e) => '${escapeXml(e.key)}="${escapeXml(e.value)}"')
      .join(' ');
}

String convertColor(String color) {
  return color == 'transparent' ? color : '#$color';
}
