import 'package:flutter/material.dart';

class CbtTextWidget extends StatelessWidget {
  const CbtTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            'There is a connection between your thoughts, behaviour and feelings. CBT aims to get you to feel better by changing your thoughts and your behaviour.',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            'Moods, emotions, feelings (rate 0%-100%): Identify your feelings. Be careful and list only feelings and not thoughts since those will be listed separately. \n \n Rate these feelings on a scale of 0-100% with - being not present and 100 being experiencing this feeling most intensely. The ratings do not need to add up to 100%.',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            'Automatic thoughts (assumptions): What were you thinking when this happened? Make this personal, specific, have an impact on you and ideally negative so you can work on your negative thoughts. Think about the implications of whatever happened. So what? Write your "hot thought" in ALLCAPS: the one which provokes the most intense reaction from you.',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            'Next list down evidence supporting hot thought: Facts only.',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            'Next list down evidence NOT supporting hot thought: Facts only.',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            'Alternative/balanced thought: Weigh the evidence for and against your hot thought. Write a more realistic thought that takes into account this evidence.',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            'Re-rate mood (0%-100%): After looking at the evidence and gaining a more objective perspective on the event, re-evaluate your mood.',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
