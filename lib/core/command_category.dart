enum CommandCategory {
  assets('Assets'),
  project('Project'),
  environment('Environment'),
  development('Development'),
  extension('Extension'),
  dependency('Dependencies'),
  localization('Localization'),
  codeGeneration('Code Generation'),
  run('Run'),
  build('Build'),
  distribution('Distribution'),
  feature('Features'),
  utility('Utilities');

  final String title;

  const CommandCategory(this.title);
}
