import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension MaterialTesterExtension on WidgetTester {
  Future<void> pumpMaterialWidget(
    Widget widget, {
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
    bool wrapWithView = true,
  }) {
    final effectiveWidget = MaterialApp(
      home: Material(
        child: widget,
      ),
    );

    return pumpWidget(
      effectiveWidget,
      duration: duration,
      phase: phase,
      wrapWithView: wrapWithView,
    );
  }
}

extension CommonFindersExtension on CommonFinders {
  Finder descendantIcon({
    required FinderBase<Element> of,
    required IconData icon,
    bool matchRoot = false,
    bool skipOffstage = true,
  }) {
    return find.descendant(
      of: of,
      matching: find.byIcon(icon),
      matchRoot: matchRoot,
      skipOffstage: skipOffstage,
    );
  }
}
