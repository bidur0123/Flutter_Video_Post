import 'package:blackcofferr/view/screens/display_current_video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackcofferr/controller/auth_controller.dart';
import 'package:blackcofferr/controller/profile_controller.dart';
import 'package:blackcofferr/view/screens/Home.dart';
import 'package:blackcofferr/view/screens/display_screen.dart';
import 'package:blackcofferr/view/widgets/customAddIcon.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
   ProfileScreen({Key? key , required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   final ProfileController profileController = Get.put(ProfileController());
   final AuthController authController = Get.put(AuthController());


   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    profileController.updateUseId(widget.uid);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init:ProfileController(),
        builder: (controller) {
          return
            Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Color(0xff133D59),
                  title: const Text(
                    "ProfilePage",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                body: controller.user.isEmpty
                  ? const Center(
                    child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: controller.user['profilePic'],
                                  fit: BoxFit.contain,
                                  height: 100,
                                  width: 100,
                                  placeholder: (context , url) => const CircularProgressIndicator(),
                                  errorWidget: (context , url , error) => const Icon(Icons.error),
                       ),
                      ),
                    ],
                  ),
                          const SizedBox(height: 20,),
                          Text('@${controller.user["name"]}'
                            , style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black
                          ),
                          ),
                        const SizedBox(height: 20,),
                        const Divider(indent: 10 , endIndent: 10, thickness: 1,color: Colors.black,),
                        const SizedBox(height: 30,),
                          GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 ,
                              crossAxisSpacing: 5
                          ),
                            itemCount: controller.user['thumbnails'].length,
                            itemBuilder: (context , index) {
                              String thumbnail = controller.user['thumbnails'][index];
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayCurrentVideo()));
                              },
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: thumbnail,
                                errorWidget: (context , url , error) => const Icon(Icons.error),
                              ),
                            );
                   })
                ],
              ),
            ),
          ));
        });
  }
}
