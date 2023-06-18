///
class ToJsonTemplate {
  ///
  const ToJsonTemplate({required this.fields});

  ///
  final Map<String, dynamic> fields;

  @override
  String toString() {
    return '''
Map<String, dynamic> toJson() {
    return {
      ${fields.entries.map((entry) => "'${entry.key}': ${entry.key},").join('\n')}
    };
  }
''';
  }
}
