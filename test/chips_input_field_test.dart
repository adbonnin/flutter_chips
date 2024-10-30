import 'dart:async';

import 'package:chips/chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test.dart';

void main() {
  testWidgets('should display a list of input chips', (tester) async {
    // given:
    const values = ['apple', 'banana'];

    // and:
    final widget = ChipsInputField(
      values: values,
      fromText: (c) => c,
    );

    // when:
    await tester.pumpMaterialWidget(widget);

    // then:
    expect(find.byType(InputChip), findsNWidgets(2));

    expect(find.widgetWithText(InputChip, 'apple'), findsOneWidget);
    expect(find.widgetWithText(InputChip, 'banana'), findsOneWidget);
  });

  testWidgets('should add a chip', (tester) async {
    // given:
    var values = <String>[];
    final onChanged = Completer<List<String>>();

    // and:
    final widget = ChipsInputField<String>(
      values: values,
      onChanged: onChanged.complete,
      fromText: (c) => c,
    );

    // when:
    await tester.pumpMaterialWidget(widget);

    // then:
    expect(find.byType(InputChip), findsNothing);

    // when:
    await tester.enterText(find.byType(TextFormField), 'test');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    // then:
    expect(onChanged.isCompleted, isTrue);
    expect(await onChanged.future, ['test']);
  });
}
