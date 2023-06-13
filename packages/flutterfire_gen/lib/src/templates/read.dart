import '../firestore_document_visitor.dart';

///  Writes Read class to the given [StringBuffer].
void writeReadClass({
  required StringBuffer buffer,
  required String readClassName,
  required String documentName,
  required FirestoreDocumentVisitor visitor,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln('class $readClassName {');
  _writeConstructor(
    buffer: buffer,
    readClassName: readClassName,
    fields: fields,
  );
  _writeFields(buffer: buffer, fields: fields);
  _writeFromJson(buffer: buffer, fields: fields);
  _writeToJson(
    buffer: buffer,
    readClassName: readClassName,
    visitor: visitor,
    fields: fields,
  );
  _writeFromDocumentSnapshot(
    buffer: buffer,
    readClassName: readClassName,
    documentName: documentName,
  );
  _writeCopyWith(buffer: buffer, readClassName: readClassName, fields: fields);
  buffer.writeln('}');
}

///
void _writeConstructor({
  required StringBuffer buffer,
  required String readClassName,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln('const $readClassName({');
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
  required String readClassName,
  required FirestoreDocumentVisitor visitor,
  required Map<String, dynamic> fields,
}) {
  buffer
      .writeln('factory $readClassName.fromJson(Map<String, dynamic> json) {');
  buffer.writeln('return $readClassName(');

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
  required String readClassName,
  required String documentName,
}) {
  buffer.writeln(
    'factory $readClassName.fromDocumentSnapshot(DocumentSnapshot ds) {',
  );
  buffer.writeln('final data = ds.data()! as Map<String, dynamic>;');
  buffer.writeln('return $readClassName.fromJson(<String, dynamic>{');
  buffer.writeln('...data,');
  buffer.writeln("'${documentName}Id': ds.id,");
  buffer.writeln('});');
  buffer.writeln('}');
  buffer.writeln();
}

void _writeCopyWith({
  required StringBuffer buffer,
  required String readClassName,
  required Map<String, dynamic> fields,
}) {
  buffer.writeln('$readClassName copyWith({');
  for (final entry in fields.entries) {
    buffer.writeln('${entry.value}? ${entry.key},');
  }
  buffer.writeln('}) {');
  buffer.writeln('return $readClassName(');
  for (final entry in fields.entries) {
    buffer.writeln('${entry.key}: ${entry.key} ?? this.${entry.key},');
  }
  buffer.writeln(');');
  buffer.writeln('}');
}
