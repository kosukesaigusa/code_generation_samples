///
class TranslateToTypeScript {
  ///
  const TranslateToTypeScript({
    this.isEnum = false,
  });

  ///
  final bool isEnum;

  /// A RegExp source to check if the annotated class is enum.
  static const isEnumRegExpSource = r'isEnum:\s*(true|false)';
}
