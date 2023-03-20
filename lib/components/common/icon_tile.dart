import 'package:flutter/material.dart';

/*

S Q U A R E T I L E

These are custom built buttons that are used as a google & apple sign in.

*/

class IconTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const IconTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
