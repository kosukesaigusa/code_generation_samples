///
sealed class Default {
  ///
  const Default();
}

/// An annotation to give default value if the field is null when reading
/// documents.
final class ReadDefault extends Default {
  /// Create a [ReadDefault].
  const ReadDefault(this.value);

  /// A default value.
  final dynamic value;

  ///
  static const typeString = 'ReadDefault';
}

/// An annotation to give default value if the field is null when creating a
/// document.
final class CreateDefault extends Default {
  /// Create a [CreateDefault].
  const CreateDefault(this.value);

  /// A default value.
  final dynamic value;

  ///
  static const typeString = 'CreateDefault';
}

/// An annotation to give default value if the field is null when updating a
/// document.
final class UpdateDefault extends Default {
  /// Create a [UpdateDefault].
  const UpdateDefault(this.value);

  /// A default value.
  final dynamic value;

  ///
  static const typeString = 'UpdateDefault';
}
