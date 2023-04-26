import 'dart:math';

import 'package:ajourn_app/components/cbt/cbt_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../components/common/text_fields.dart';
import '../../providers/anxiety_provider.dart';
import '../../services/prediction_service.dart';
import '../home/home_page.dart';

class CBTScreen extends StatefulWidget {
  const CBTScreen({super.key});

  @override
  State<CBTScreen> createState() => _CBTScreenState();
}

class _CBTScreenState extends State<CBTScreen> {
  String date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  final links = [
    'https://www.youtube.com/watch?v=8vkYJf8DOsc',
    'https://www.youtube.com/watch?v=FW1yK8ahhas',
    'https://www.youtube.com/watch?v=oaJDfWCn4fI',
    'https://www.youtube.com/watch?v=ukb186f8XEI',
  ];

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _contentController.addListener(checkInputLength);
    // generates a new Random object
    final random = Random();
    var randomLink = links[random.nextInt(links.length)];

    final videoID = YoutubePlayer.convertUrlToId(randomLink);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false));
  }

  void checkInputLength() {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    setState(() {
      if (_contentController.text.length >= 20) {
        myProvider.isCbtEntryBtnDisabled = false;
      } else {
        myProvider.isCbtEntryBtnDisabled = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w500),
        title: const Text('CBT Section'),
      ),
      body: Scrollbar(
        thickness: 3,
        trackVisibility: true,
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
              const CbtTextWidget(),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                child: MyTextFields(
                    titleController: _titleController,
                    date: date,
                    contentController: _contentController),
              ),
              Center(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: myProvider.isCbtEntryBtnDisabled
                      ? null
                      : () async {
                          // Generate a v4 (random) id
                          var uuid = const Uuid();
                          String id = uuid.v4();
                          FirebaseFirestore.instance.collection('Entries').add({
                            "entry_title": _titleController.text,
                            "date": date,
                            "entry_content": _contentController.text,
                            "uid": id
                          }).then((value) {
                            Predictions()
                                .predictResponse(_contentController.text, id);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const HomePage()),
                                ));
                          }).catchError((error) {
                            Navigator.pop(context);
                          });
                        },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
