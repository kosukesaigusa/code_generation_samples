import '../firestore_document_visitor.dart';
import '../flutterfire_gen.dart';

///  Writes Read class to the given [StringBuffer].
void writeReadClass({
  required StringBuffer buffer,
  required FirestoreDocumentConfig config,
  required FirestoreDocumentVisitor visitor,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln('class ${config.readClassName} {');
  _writeConstructor(buffer: buffer, config: config, fields: fields);
  _writeFields(buffer: buffer, fields: fields);
  _writeFromJson(buffer: buffer, fields: fields);
  _writeToJson(
    buffer: buffer,
    config: config,
    visitor: visitor,
    fields: fields,
  );
  _writeFromDocumentSnapshot(buffer: buffer, config: config);
  _writeCopyWith(buffer: buffer, config: config, fields: fields);
  buffer.writeln('}');
}

///
void _writeConstructor({
  required StringBuffer buffer,
  required FirestoreDocumentConfig config,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln('const ${config.readClassName}({');
  for (final entry in fields.entries) {
    buffer.writeln('required this.${entry.key},');
  }
  buffer.writeln('});');
  buffer.writeln();
}

///
void _writeFields({
  required StringBuffer buffer,
  required Map<String, dynamic> fields,
}) {
  for (final entry in fields.entries) {
    buffer.writeln('final ${entry.value} ${entry.key};');
  }
  buffer.writeln();
}

void _writeFromJson({
  required StringBuffer buffer,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln('Map<String, dynamic> toJson() {');
  buffer.writeln('return {');
  for (final entry in fields.entries) {
    buffer.writeln("'${entry.key}': ${entry.key},");
  }
  buffer.writeln('};');
  buffer.writeln('}');
}

void _writeToJson({
  required StringBuffer buffer,
  required FirestoreDocumentConfig config,
  required FirestoreDocumentVisitor visitor,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln('factory ${config.readClassName}'
      '.fromJson(Map<String, dynamic> json) {');
  buffer.writeln('return ${config.readClassName}(');

  for (final entry in fields.entries) {
    final key = entry.key;
    final value = entry.value;
    final defaultValue = visitor.defaultValues[key];
    if (defaultValue != null) {
      buffer.writeln("$key: json['$key'] as $value? ?? $defaultValue,");
    } else {
      buffer.writeln("$key: json['$key'] as $value,");
    }
  }
  buffer.writeln(');');
  buffer.writeln('}');
  buffer.writeln();
}

void _writeFromDocumentSnapshot({
  required StringBuffer buffer,
  required FirestoreDocumentConfig config,
}) {
  buffer.writeln('factory ${config.readClassName}'
      '.fromDocumentSnapshot(DocumentSnapshot ds) {');
  buffer.writeln('final data = ds.data()! as Map<String, dynamic>;');
  buffer.writeln('return ${config.readClassName}.fromJson(<String, dynamic>{');
  buffer.writeln('...data,');
  buffer.writeln("'${config.documentName}Id': ds.id,");
  buffer.writeln('});');
  buffer.writeln('}');
  buffer.writeln();
}

void _writeCopyWith({
  required StringBuffer buffer,
  required FirestoreDocumentConfig config,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln('${config.readClassName} copyWith({');
  for (final entry in fields.entries) {
    buffer.writeln('${entry.value}? ${entry.key},');
  }
  buffer.writeln('}) {');
  buffer.writeln('return ${config.readClassName}(');
  for (final entry in fields.entries) {
    buffer.writeln('${entry.key}: ${entry.key} ?? this.${entry.key},');
  }
  buffer.writeln(');');
  buffer.writeln('}');
}
