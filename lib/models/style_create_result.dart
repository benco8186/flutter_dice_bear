import 'dart:collection';

class StyleCreateResult {
  final StyleCreateResultAttributes attributes;
  String body;
  final Map<String, dynamic> Function()? extra;

  StyleCreateResult({required this.attributes, required this.body, this.extra});
}

class StyleCreateResultAttributes extends MapBase<String, String> {
  String viewBox;

  StyleCreateResultAttributes({required this.viewBox});

  final Map<String, String> _additionalAttributes = {};

  @override
  String? operator [](Object? key) {
    if (key == 'viewBox') return viewBox;
    return _additionalAttributes[key];
  }

  @override
  void operator []=(String key, String value) {
    if (key == 'viewBox') {
      viewBox = value;
    } else {
      _additionalAttributes[key] = value;
    }
  }

  @override
  void clear() {
    _additionalAttributes.clear();
    // viewBox reste inchangé car c'est un attribut requis
  }

  @override
  Iterable<String> get keys => ['viewBox', ..._additionalAttributes.keys];

  @override
  String? remove(Object? key) {
    if (key == 'viewBox') return null; // Ne peut pas supprimer viewBox
    return _additionalAttributes.remove(key);
  }
}
