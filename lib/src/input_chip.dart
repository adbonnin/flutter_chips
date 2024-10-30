import 'package:flutter/material.dart';

typedef InputChipBuilder = Widget Function<T>(
  BuildContext context,
  T value, {
  required bool selected,
  required bool isEnabled,
  ValueChanged<bool>? onSelected,
  VoidCallback? onDeleted,
});

Widget defaultInputChipBuilder<T>(
  BuildContext context,
  T chip, {
  required bool selected,
  required bool isEnabled,
  ValueChanged<bool>? onSelected,
  VoidCallback? onDeleted,
}) {
  return InputChip(
    label: Text(chip.toString()),
    selected: selected,
    isEnabled: isEnabled,
    onSelected: onSelected,
    onDeleted: onDeleted,
    showCheckmark: false,
  );
}
