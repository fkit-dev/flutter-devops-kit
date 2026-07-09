class TemplateModule {
  const TemplateModule({required this.description});

  final String description;

  factory TemplateModule.fromMap(Map<dynamic, dynamic> map) {
    return TemplateModule(description: map['description']?.toString() ?? '');
  }
}
