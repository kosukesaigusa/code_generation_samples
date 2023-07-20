import '../config.dart';

///
class FakeFirebaseFirestoreTemplate {
  ///
  const FakeFirebaseFirestoreTemplate({
    required this.config,
  });

  ///
  final FirestoreDocumentConfig config;

  @override
  String toString() {
    if (config.useFakeFirebaseFirestore) {
      return 'final fakeDb = FakeFirebaseFirestore();';
    }
    return '';
  }
}
