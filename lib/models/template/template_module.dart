/// Defines metadata for a module available in an FKIT template.
class TemplateModule {
  /// Creates a template module with the specified [description].
  const TemplateModule({
    required this.description,
  });

  /// A description of the template module.
  final String description;

  /// Creates a template module from the provided [map].
  factory TemplateModule.fromMap(Map<dynamic, dynamic> map) {
    return TemplateModule(
      description: map['description']?.toString() ?? '',
    );
  }
}
