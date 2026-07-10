/// Defines a step in an interactive configuration wizard.
abstract class WizardStep<T> {
  /// Collects and returns the value produced by this wizard step.
  T collect();
}
