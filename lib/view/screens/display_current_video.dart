import 'package:blackcofferr/controller/video_controller.dart';
import 'package:blackcofferr/view/screens/comment_screen.dart';
import 'package:blackcofferr/view/screens/profile_screen.dart';
import 'package:blackcofferr/view/widgets/ProfileButton.dart';
import 'package:blackcofferr/view/widgets/VideoPlayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class DisplayCurrentVideo extends StatelessWidget {
   DisplayCurrentVideo({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());


  Future<void> share(String vidId) async {
    await FlutterShare.share(
      title: 'Download videos',
      text: 'Watch Intresting short videos ',
    );
    videoController.shareVideo(vidId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff133D59),
      ),
      body: Obx(() {
        return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemCount: videoController.videoList.length,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              return InkWell(
                onDoubleTap: (){
                  videoController.likedVideo(data.id);
                },
                child:
                Stack(
                  children: [
                    TikTokVideoPlayer(
                      videoUrl: data.videoUrl,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.username,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Text(
                            data.caption,
                          ),
                          Text(
                            data.songName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 400,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3, right: 10),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: data.uid,)));
                              },
                              child: ProfileButton(
                                profilePhotoUrl: data.profilePic,
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                videoController.likedVideo(data.id);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 35,
                                    color: data.likes.contains(FirebaseAuth.instance.currentUser!.uid) ?  Colors.pinkAccent : Colors.white ,
                                  ),
                                  Text(
                                    data.likes.length.toString(),
                                    style:
                                    const TextStyle(fontSize: 15, color: Colors.white),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentScreen(id : data.id)));
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.comment,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.commentsCount.toString(),
                                    style:
                                    const TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                share(data.id);
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.reply,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.shareCount.toString(),
                                    style:
                                    const TextStyle(fontSize: 15, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        );
      }
      ),
    );
  }
}
