import 'package:flutter/material.dart';

/*

B U T T O N

This is a custom built sign in button!

*/

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonTxt;

  const LoginButton({super.key, required this.onTap, required this.buttonTxt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonTxt,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
