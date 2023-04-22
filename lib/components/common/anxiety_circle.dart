import 'package:flutter/material.dart';

class AnxietyCircle extends StatelessWidget {
  const AnxietyCircle(this.colour, {super.key});
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: colour,
        shape: BoxShape.circle,
      ),
    );
  }
}
