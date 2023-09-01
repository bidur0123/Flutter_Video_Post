import 'package:flutter/material.dart';
import 'package:blackcofferr/constants.dart';
import 'package:blackcofferr/controller/upload_video_controller.dart';
import 'package:blackcofferr/view/widgets/text_input.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
class addCaption_Screen extends StatefulWidget {
  File videoFile;
  String videoPath;

   addCaption_Screen({Key? key ,
    required this.videoFile ,
    required this.videoPath}) : super(key: key);

  @override
  State<addCaption_Screen> createState() => _addCaption_ScreenState();
}

class _addCaption_ScreenState extends State<addCaption_Screen> {
late VideoPlayerController videoPlayerController;

VideoUploadController videoUploadController = Get.put(VideoUploadController());
TextEditingController titleController = new TextEditingController();
TextEditingController descriptionController = new TextEditingController();


Widget UploadContent = Text("Upload");

uploadVid(){
  UploadContent = Text("Please Wait..");
setState(() {

});
}


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInputField(controller: titleController,
                    myIcon: Icons.title,
                    myLabelText: "title"),
                const SizedBox(height: 20,),
                TextInputField(controller: descriptionController,
                    myIcon: Icons.description,
                    myLabelText: "description"),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: (){
                    uploadVid();
                     videoUploadController.uploadVideo(
                         titleController.text,
                         descriptionController.text,
                         widget.videoPath);
                },
                  child: UploadContent ,
                  style: ElevatedButton.styleFrom(primary: buttonColor),
                )
              ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
