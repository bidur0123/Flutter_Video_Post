import 'package:blackcofferr/view/screens/display_current_video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:blackcofferr/view/screens/profile_screen.dart';
import 'package:blackcofferr/view/widgets/ProfileButton.dart';
import 'package:blackcofferr/view/widgets/VideoPlayer.dart';
import 'package:get/get.dart';
import '../../controller/video_controller.dart';

class DisplayVideo_Screen extends StatelessWidget {
   DisplayVideo_Screen({Key? key}) : super(key: key);
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
        title: const Text(
          "BLACKCOFFER",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            iconSize: 28,
            tooltip: 'notifications',
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            iconSize: 28,
            tooltip: 'notifications',
            onPressed: () {

            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: videoController.videoList.length,
                    itemBuilder: (context , index){
                       final data = videoController.videoList[index];
                       return InkWell(
                       onTap: (){
                        // videoController.likedVideo(data.id);
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayCurrentVideo()));
                       },
                         child: Padding(
                           padding: const EdgeInsets.symmetric(vertical: 2.0),
                           child: Card(
                             color: Colors.white,
                             shape: RoundedRectangleBorder(
                               side: const BorderSide(
                                   color: Colors.indigoAccent, width: 2),
                               borderRadius: BorderRadius.circular(20.0),
                             ),
                             elevation: 10.0,
                             child: Padding(
                               padding: const EdgeInsets.all(12.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Row(
                                     children: [
                                       CircleAvatar(
                                         child: InkWell(
                                           onTap: (){
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: data.uid,)));
                                           },
                                           child: ProfileButton(
                                             profilePhotoUrl: data.profilePic,
                                           ),
                                         ),
                                       ),
                                       SizedBox(width: 15.0),
                                       Column(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             data.username,
                                             style: TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.black,
                                                 fontSize: 16
                                             ),
                                           ),
                                           Text(
                                             "NewDelhi",
                                             style: TextStyle(
                                               fontWeight: FontWeight.w500,
                                               fontSize: 12,
                                               color: Colors.black
                                             ),
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                   const SizedBox(height: 10.0),
                                   Row(
                                     children: [
                                       Padding(
                                         padding:
                                         const EdgeInsets.symmetric(horizontal: 8.0),
                                         child: Text(
                                           data.caption,
                                           style: const TextStyle(
                                               fontSize: 16.0,
                                               fontWeight: FontWeight.w500,
                                               color: Colors.black87),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 10.0,
                                   ),
                                   ClipRRect(
                                     borderRadius: BorderRadius.circular(20.0),
                                     child:
                                     Container(
                                       height: 160,
                                       child: TikTokVideoPlayer(
                                         videoUrl: data.videoUrl,
                                       ),
                                     ),
                                     // FadeInImage.assetNetwork(
                                     //     fit: BoxFit.cover,
                                     //     width: MediaQuery.of(context).size.width * 1,
                                     //     height:
                                     //     MediaQuery.of(context).size.width * .5,
                                     //     placeholder: "assets/loading.gif",
                                     //     image: '',
                                     //
                                     // ),
                                   ),
                                   const SizedBox(
                                     height: 12,
                                   ),
                                   Padding(
                                     padding:
                                     const EdgeInsets.symmetric(horizontal: 10.0),
                                     child: Text(
                                       data.songName,
                                       style: const TextStyle(
                                           fontSize: 14,
                                           color: Colors.black87,
                                           fontWeight: FontWeight.normal),
                                     ),
                                   ),
                                   Row(
                                     children: [
                                       IconButton(
                                           onPressed: (){}
                                           , icon: Icon(
                                           Icons.preview_sharp,
                                         color: Colors.black,
                                       )
                                       ),
                                       Text(
                                         "2000",
                                         style: TextStyle(
                                             fontWeight: FontWeight.w500,
                                             fontSize: 15,
                                           color: Colors.black
                                         ),
                                       ),
                                       const SizedBox(width: 20.0,),
                                       Text(
                                         "#Adventure",
                                         style: TextStyle(
                                             fontWeight: FontWeight.w500,
                                             fontSize: 15,
                                           color: Colors.black
                                         ),
                                       ),
                                     ],
                                   ),
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.only(left: 18.0),
                                         child: Text(
                                           "2 days ago",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w500,
                                               fontSize: 15,
                                             color: Colors.black
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       );
                    }
                ),
            ),
          ],
        ),
      ),
    );
  }
}
