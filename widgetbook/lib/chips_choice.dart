import 'package:chips/chips.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: ChipsChoice)
Widget buildChipsChoiceUseCase(BuildContext context) {
  final onChangedEnabled = context.knobs.boolean(
    label: 'Enable onChanged',
    initialValue: true,
  );

  final onSelectionChangedEnabled = context.knobs.boolean(
    label: 'Enable onSelectionChanged',
    initialValue: true,
  );

  return ChipsChoiceUseCase(
    onChangedEnabled: onChangedEnabled,
    onSelectionChangedEnabled: onSelectionChangedEnabled,
  );
}

class ChipsChoiceUseCase extends StatefulWidget {
  const ChipsChoiceUseCase({
    super.key,
    required this.onChangedEnabled,
    required this.onSelectionChangedEnabled,
  });

  final bool onChangedEnabled;
  final bool onSelectionChangedEnabled;

  @override
  State<ChipsChoiceUseCase> createState() => _ChipsChoiceUseCaseState();
}

class _ChipsChoiceUseCaseState extends State<ChipsChoiceUseCase> {
  var _values = ['Apple', 'Apricot', 'Banana', 'Kiwi'];
  var _selected = {'Banana'};

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChipsChoice(
        values: _values,
        selected: _selected,
        onChanged: widget.onChangedEnabled ? _onChanged : null,
        onSelectionChanged: widget.onSelectionChangedEnabled ? _onSelectionChanged : null,
      ),
    );
  }

  void _onChanged(List<String> values) {
    setState(() => _values = values);
  }

  void _onSelectionChanged(Set<String> selected) {
    setState(() => _selected = selected);
  }
}
