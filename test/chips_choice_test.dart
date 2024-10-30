import 'package:chips/chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'test.dart';

@GenerateMocks([OnChanged, OnSelectionChanged])
import 'chips_choice_test.mocks.dart';

void main() {
  testWidgets('should display a list of input chips', (tester) async {
    // given:
    const chips = ['apple', 'banana'];

    // and:
    const widget = ChipsChoice(values: chips);

    // when:
    await tester.pumpMaterialWidget(widget);

    // then:
    expect(find.byType(InputChip), findsNWidgets(2));

    expect(find.widgetWithText(InputChip, 'apple'), findsOneWidget);
    expect(find.widgetWithText(InputChip, 'banana'), findsOneWidget);
  });

  testWidgets('should select an input chip', (tester) async {
    // given:
    const chips = ['apple', 'banana'];
    const selected = {'apple'};

    // and:
    final onSelectionChanged = MockOnSelectionChanged();

    // and:
    final widget = ChipsChoice(
      values: chips,
      selected: selected,
      onSelectionChanged: onSelectionChanged.call,
    );

    // when:
    await tester.pumpMaterialWidget(widget);

    // then:
    expect(tester.firstWidget<InputChip>(find.widgetWithText(InputChip, 'apple')).selected, true);
    expect(tester.firstWidget<InputChip>(find.widgetWithText(InputChip, 'banana')).selected, false);

    // when:
    await tester.tap(find.text('apple'));

    // then:
    verify(onSelectionChanged.call({})).called(1);

    // when:
    await tester.tap(find.text('banana'));

    // then:
    verify(onSelectionChanged.call({'apple', 'banana'})).called(1);
  });

  testWidgets('should delete an input chip', (tester) async {
    // given:
    const chips = ['apple', 'banana'];

    // and:
    final onChanged = MockOnChanged();

    // and:
    final widget = ChipsChoice(
      values: chips,
      onChanged: onChanged.call,
    );

    // when:
    await tester.pumpMaterialWidget(widget);

    // and:
    await tester.tap(find.descendantIcon(of: find.widgetWithText(InputChip, 'apple'), icon: Icons.clear));

    // then:
    verify(onChanged.call(['banana'])).called(1);
  });
}

abstract class OnChanged {
  void call(List<String> value);
}

abstract class OnSelectionChanged {
  void call(Set<String> value);
}