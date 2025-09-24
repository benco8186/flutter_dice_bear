import 'package:flutter_dice_bear/models/avatar_style.dart';
import 'package:flutter_dice_bear/utils/functions.dart';

abstract class LicenceUtils {
  static String licenceToXml(AvatarStyle style) {
    final title = style.meta.title;
    final creator = style.meta.creator;
    final source = style.meta.source;
    final license = style.meta.license?.url;
    final rights = licenceToText(style);

    if (title == null &&
        creator == null &&
        source == null &&
        license == null &&
        rights.isEmpty) {
      return '';
    }

    return '''
<metadata
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:dcterms="http://purl.org/dc/terms/">
  <rdf:RDF>
    <rdf:Description>
      ${title != null ? "<dc:title>${escapeXml(title)}</dc:title>" : ""}
      ${creator != null ? "<dc:creator>${escapeXml(creator)}</dc:creator>" : ""}
      ${source != null ? "<dc:source xsi:type=\"dcterms:URI\">${escapeXml(source)}</dc:source>" : ""}
      ${license != null ? "<dcterms:license xsi:type=\"dcterms:URI\">${escapeXml(license)}</dcterms:license>" : ""}
      ${rights.isNotEmpty ? "<dc:rights>${escapeXml(rights)}</dc:rights>" : ""}
    </rdf:Description>
  </rdf:RDF>
</metadata>
''';
  }

  static String licenceToText(AvatarStyle style) {
    var title = style.meta.title != null ? "„${style.meta.title}”" : "Design";
    var creator = "„${style.meta.creator ?? "Unknown"}”";

    if (style.meta.source != null) {
      title += " (${style.meta.source})";
    }

    var result = '';

    if (style.meta.license?.name != "MIT" &&
        style.meta.creator != "DiceBear" &&
        style.meta.title != null) {
      result += "Remix of ";
    }

    result += "$title by $creator";

    if (style.meta.license?.name != null) {
      result += ", licensed under „${style.meta.license!.name}”";

      if (style.meta.license?.url != null) {
        result += " (${style.meta.license!.url})";
      }
    }

    return result;
  }
}
