import '../../config.dart';

///
class DeleteClassTemplate {
  ///
  const DeleteClassTemplate({required this.config});

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    return 'export class ${config.deleteClassName} {}';
  }
}
