import 'package:flutter/material.dart';

Widget entryCard(Function()? onTap, String title, String date, String content) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 200,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "PlayfairDisplay"),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              date,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              content,
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}
