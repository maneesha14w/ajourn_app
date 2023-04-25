import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  const MyTextFields({
    Key? key,
    required TextEditingController titleController,
    required this.date,
    required TextEditingController contentController,
  })  : _titleController = titleController,
        _contentController = contentController,
        super(key: key);

  final TextEditingController _titleController;
  final String date;
  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(date,
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
        const SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          maxLength: 3483,
          controller: _contentController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Start Journaling..',
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ],
    );
  }
}
