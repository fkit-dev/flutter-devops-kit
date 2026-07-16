/// Supported data types for configurable FKIT module options.
enum ModuleOptionType {
  /// A plain text value.
  string,

  /// A boolean value (`true` or `false`).
  bool,

  /// An integer value.
  int,

  /// A floating-point value.
  double,

  /// A hexadecimal color value (for example `#2563EB`).
  color,

  /// A predefined value selected from a fixed list of options.
  enumType,
}
