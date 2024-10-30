import 'package:chips/chips.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/showcase_card.dart';

@widgetbook.UseCase(name: 'Default', type: ChipsInputField)
Widget buildChipsInputFieldUseCase(BuildContext context) {
  final onChangedEnabled = context.knobs.boolean(
    label: 'Enable onChanged',
    initialValue: true,
  );

  return ChipsInputFieldUseCase(
    onChangedEnabled: onChangedEnabled,
  );
}

class ChipsInputFieldUseCase extends StatefulWidget {
  const ChipsInputFieldUseCase({
    super.key,
    required this.onChangedEnabled,
  });

  final bool onChangedEnabled;

  @override
  State<ChipsInputFieldUseCase> createState() => _ChipsInputFieldUseCaseState();
}

class _ChipsInputFieldUseCaseState extends State<ChipsInputFieldUseCase> {
  var _values = ['Apple', 'Apricot', 'Banana', 'Kiwi'];

  @override
  Widget build(BuildContext context) {
    return ShowcaseCard(
      child: ChipsInputField(
        values: _values,
        onChanged: widget.onChangedEnabled ? _onChanged : null,
        fromText: (text) => text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _onChanged(List<String> values) {
    setState(() => _values = values);
  }
}
