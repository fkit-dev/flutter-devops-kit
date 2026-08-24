import 'package:flutter/material.dart';

/// A reusable scaffold with common application behaviors.
///
/// Features:
/// - SafeArea support
/// - Optional padding
/// - Pull-to-refresh
/// - Keyboard dismissal
/// - Background color/gradient
/// - Loading overlay
/// - Custom overlay
/// - Standard Scaffold configuration
class AppScaffold extends StatelessWidget {
  /// Creates an application scaffold.
  const AppScaffold({
    super.key,
    required this.body,
    this.scaffoldKey,
    this.appBar,

    // Layout
    this.safeArea = true,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.padding,

    // Background
    this.backgroundColor,
    this.backgroundGradient,

    // UX
    this.dismissKeyboardOnTap = true,
    this.onRefresh,

    // Overlay
    this.loading = false,
    this.loadingWidget,
    this.overlay,

    // Scaffold
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  });

  /// Scaffold key.
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// App bar.
  final PreferredSizeWidget? appBar;

  /// Main content.
  final Widget body;

  // ---------------------------------------------------------------------------
  // Layout
  // ---------------------------------------------------------------------------

  /// Wraps the body with [SafeArea].
  final bool safeArea;

  /// Applies safe area to the top.
  final bool safeAreaTop;

  /// Applies safe area to the bottom.
  final bool safeAreaBottom;

  /// Padding applied around the body.
  final EdgeInsetsGeometry? padding;

  // ---------------------------------------------------------------------------
  // Background
  // ---------------------------------------------------------------------------

  /// Scaffold background color.
  final Color? backgroundColor;

  /// Optional background gradient.
  final Gradient? backgroundGradient;

  // ---------------------------------------------------------------------------
  // UX
  // ---------------------------------------------------------------------------

  /// Dismisses the keyboard when tapping outside focused fields.
  final bool dismissKeyboardOnTap;

  /// Enables pull-to-refresh.
  final RefreshCallback? onRefresh;

  // ---------------------------------------------------------------------------
  // Overlay
  // ---------------------------------------------------------------------------

  /// Shows a loading overlay.
  final bool loading;

  /// Custom loading widget.
  final Widget? loadingWidget;

  /// Custom overlay widget.
  final Widget? overlay;

  // ---------------------------------------------------------------------------
  // Scaffold
  // ---------------------------------------------------------------------------

  final Widget? drawer;

  final Widget? endDrawer;

  final Widget? bottomNavigationBar;

  final Widget? bottomSheet;

  final Widget? floatingActionButton;

  final FloatingActionButtonLocation?
      floatingActionButtonLocation;

  final List<Widget>? persistentFooterButtons;

  final bool resizeToAvoidBottomInset;

  final bool extendBody;

  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    Widget content = body;

    // Padding
    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    // SafeArea
    if (safeArea) {
      content = SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: content,
      );
    }

    // Pull to refresh
    if (onRefresh != null) {
      content = RefreshIndicator(
        onRefresh: onRefresh!,
        child: content,
      );
    }

    // Keyboard dismiss
    if (dismissKeyboardOnTap) {
      content = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: content,
      );
    }

    // Background
    content = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: backgroundGradient,
      ),
      child: SizedBox.expand(
        child: content,
      ),
    );

    final scaffold = Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar:
          extendBodyBehindAppBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton:
          floatingActionButton,
      floatingActionButtonLocation:
          floatingActionButtonLocation,
      bottomNavigationBar:
          bottomNavigationBar,
      bottomSheet: bottomSheet,
      persistentFooterButtons:
          persistentFooterButtons,
      body: content,
    );

    if (!loading && overlay == null) {
      return scaffold;
    }

    return Stack(
      children: [
        scaffold,
        if (loading)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black26,
              child: Center(
                child: loadingWidget ??
                    const CircularProgressIndicator(),
              ),
            ),
          ),
        if (overlay != null)
          Positioned.fill(child: overlay!),
      ],
    );
  }
}