import 'package:flutter/material.dart';

class ShowcaseCard extends StatelessWidget {
  const ShowcaseCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          child: child,
        ),
      ),
    );
  }
}
