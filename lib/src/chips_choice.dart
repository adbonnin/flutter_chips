import 'package:chips/src/input_chip.dart';
import 'package:flutter/material.dart';

/// This widget is inspired by the design of the [SegmentedButton].
class ChipsChoice<T> extends StatelessWidget {
  const ChipsChoice({
    super.key,
    required this.values,
    this.selected = const {},
    this.isEnabled,
    this.onChanged,
    this.onSelectionChanged,
    this.chipBuilder = defaultInputChipBuilder,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 8.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 12.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  });

  final Iterable<T> values;
  final Set<T> selected;
  final Set<T>? isEnabled;
  final ValueChanged<List<T>>? onChanged;
  final ValueChanged<Set<T>>? onSelectionChanged;
  final InputChipBuilder chipBuilder;
  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final children = values //
        .map((value) => _buildChip(context, value))
        .toList(growable: false);

    return Wrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      children: children,
    );
  }

  Widget _buildChip(BuildContext context, T value) {
    void onSelected(bool nextSelected) {
      if (nextSelected) {
        onSelectionChanged?.call({...selected, value});
      } //
      else {
        onSelectionChanged?.call({...selected}..remove(value));
      }
    }

    return chipBuilder(
      context,
      value,
      selected: selected.contains(value),
      isEnabled: isEnabled?.contains(value) ?? true,
      onSelected: onSelectionChanged == null ? null : onSelected,
      onDeleted: onChanged == null ? null : () => onChanged?.call([...values]..remove(value)),
    );
  }
}
