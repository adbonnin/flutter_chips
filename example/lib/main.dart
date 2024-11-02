import 'package:chips/chips.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chips Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _values = ['Apple', 'Apricot', 'Banana', 'Kiwi'];
  var _selected = {'Banana'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChipsChoice(
              values: _values,
              selected: _selected,
              onChanged: _onChanged,
              onSelectionChanged: _onSelectionChanged,
            ),
            const SizedBox(height: 24),
            ChipsInputField(
              values: _values,
              onChanged: _onChanged,
              fromText: (text) => text,
            )
          ],
        ),
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
