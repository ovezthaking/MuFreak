import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mufreak/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfrimScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  //final String thumbnailPath;
  const ConfrimScreen({super.key, required this.videoFile, required this.videoPath,});

  @override
  State<ConfrimScreen> createState() => _ConfrimScreenState();
}

class _ConfrimScreenState extends State<ConfrimScreen> {
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(height: 30,),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-20,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextInputField(controller: songController, labelText: 'Song Name', icon: Icons.music_note_sharp),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width-20,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextInputField(controller: captionController, labelText: 'Caption', icon: Icons.closed_caption),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {}, 
                    child: Text(
                      'Share!', 
                      style: TextStyle(
                        fontSize: 20, 
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
        )
      )
    );
  }
}