/// Categories used to group FKIT commands by functionality.
enum CommandCategory {
  /// Commands for managing project assets.
  assets('Assets'),

  /// Commands for project configuration and management.
  project('Project'),

  /// Commands for managing development environments.
  environment('Environment'),

  /// Commands that support development workflows.
  development('Development'),

  /// Commands for managing extensions.
  extension('Extension'),

  /// Commands for managing project dependencies.
  dependency('Dependencies'),

  /// Commands for localization workflows.
  localization('Localization'),

  /// Commands for generating source code.
  codeGeneration('Code Generation'),

  /// Commands for running Flutter applications.
  run('Run'),

  /// Commands for building Flutter applications.
  build('Build'),

  /// Commands for application distribution.
  distribution('Distribution'),

  /// Commands for managing project features.
  feature('Features'),

  /// General-purpose utility commands.
  utility('Utilities');

  /// The human-readable title of this command category.
  final String title;

  /// Creates a command category with the specified display [title].
  const CommandCategory(this.title);
}
