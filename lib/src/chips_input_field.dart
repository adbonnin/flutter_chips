import 'package:chips/src/collection/iterable.dart';
import 'package:chips/src/input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wrapfit/wrapfit.dart';

class ChipsInputField<T> extends StatefulWidget {
  const ChipsInputField({
    super.key,
    this.values = const [],
    required this.fromText,
    this.chipBuilder = defaultInputChipBuilder,
    this.onChanged,
    this.textFieldViewValidator,
    this.decoration,
  });

  final Iterable<T> values;
  final T Function(String text) fromText;
  final InputChipBuilder chipBuilder;
  final ValueChanged<List<T>>? onChanged;
  final FormFieldValidator<String>? textFieldViewValidator;
  final InputDecoration? decoration;

  @override
  State<ChipsInputField<T>> createState() => _ChipsInputFieldState<T>();
}

class _ChipsInputFieldState<T> extends State<ChipsInputField<T>> {
  final _textFieldController = TextEditingController();
  final _keyboardFocusNode = FocusNode();
  final _textFieldFocusNode = FocusNode();

  late Iterable<T> _values;

  var _isLastSelected = false;

  @override
  void initState() {
    super.initState();

    _values = widget.values;
    _textFieldFocusNode.addListener(_onTextFieldFocusChanged);
    _textFieldController.addListener(_onTextFieldChanged);
  }

  @override
  void didUpdateWidget(covariant ChipsInputField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.values != oldWidget.values) {
      _values = widget.values;
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _textFieldFocusNode.dispose();
    _keyboardFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = _values //
        .mapIndexed(_buildChip)
        .toList(growable: false);

    Widget effectiveWidget = Wrap2(
      spacing: 8,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...children,
        Wrapped(
          fit: WrapFit.runTight,
          child: KeyboardListener(
            focusNode: _keyboardFocusNode,
            onKeyEvent: _onKeyEvent,
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
              controller: _textFieldController,
              focusNode: _textFieldFocusNode,
              maxLines: 1,
              onFieldSubmitted: _onFieldSubmitted,
              validator: widget.textFieldViewValidator,
            ),
          ),
        ),
      ],
    );

    if (widget.decoration != null) {
      effectiveWidget = InputDecorator(
        decoration: widget.decoration!,
        child: effectiveWidget,
      );
    }

    return effectiveWidget;
  }

  Widget _buildChip(int index, T value) {
    return widget.chipBuilder(
      context,
      value,
      selected: _isLastSelected && index == (_values.length - 1),
      onDeleted: () => _removeAt(index),
      isEnabled: true,
    );
  }

  void _onFieldSubmitted(String text) {
    if (text.isEmpty) {
      return;
    }

    final value = widget.fromText(text);
    widget.onChanged?.call([..._values, value]);

    _textFieldController.clear();
    _textFieldFocusNode.requestFocus();
  }

  void _onTextFieldFocusChanged() {
    if (_textFieldFocusNode.hasFocus) {
      setState(() {
        _isLastSelected = false;
      });
    }
  }

  void _onTextFieldChanged() {
    final text = _textFieldController.value.text;

    if (text.isNotEmpty) {
      setState(() {
        _isLastSelected = false;
      });
    }
  }

  void _onKeyEvent(KeyEvent event) {
    final text = _textFieldController.value.text;

    final isBackspaceUp = event is KeyUpEvent && //
        event.logicalKey == LogicalKeyboardKey.backspace;

    if (isBackspaceUp) {
      if (text.isNotEmpty || _values.isEmpty) {
        return;
      }

      if (!_isLastSelected) {
        setState(() {
          _isLastSelected = true;
        });
      } //
      else if (_values.isNotEmpty) {
        _removeAt(_values.length - 1);
      }
    }
  }

  void _removeAt(int index) {
    widget.onChanged?.call([..._values]..removeAt(index));
  }
}
