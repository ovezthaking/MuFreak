import 'package:flutter/material.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/views/screens/comment_screen.dart';
import 'package:mufreak/views/screens/home_screen.dart';
import 'package:mufreak/views/widgets/circle_animation.dart';
import 'package:mufreak/views/widgets/video_player_item.dart';
import 'package:mufreak/controllers/activity_controller.dart';
import 'package:get/get.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({super.key});

  final ActivityController activityController = Get.put(ActivityController());

  buildProfile(String profilePhoto){
    return InkWell(
      onTap: () {},
      child: SizedBox(width: 60, height: 60, child:Stack(
      children: [
        Positioned(left: 5, child: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image(
              image: NetworkImage(profilePhoto),
              fit: BoxFit.cover,
            ),
          ),
        ),),
      ],
    ),
    ),
    );
  }

  buildMusicAlbum(String profilePhoto){
    return SizedBox(width: 60, height: 60, child:Column(children: [
      Container(
        padding: const EdgeInsets.all(11),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.grey, Colors.white,]),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image(
            image: NetworkImage(profilePhoto),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],),);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          child: const Text(
            "All activity",
            style: TextStyle(color: Color.fromARGB(230, 255, 255, 255)),
          ),
        ),
        titleSpacing: 0,
      ),
      body: Obx(
        () {
          return PageView.builder(
            itemCount: activityController.followingVideos.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = activityController.followingVideos[index];
              return Stack(
                children: [
                  VideoPlayerItem(videoUrl: data.videoUrl,),
                  Column(
                    children: [
                      const SizedBox(height: 100,),
                      Expanded(child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20,),
                              child: Column(
                                mainAxisSize: MainAxisSize.min, 
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data.username,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data.caption,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.music_note_rounded, size:15, color: Colors.white,),
                                      Text(
                                      data.songname,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 130, 173, 80),
                                        fontWeight: FontWeight.bold,
                                      ),
                                     ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(top: size.height/5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildProfile(data.profilePhoto),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () => activityController.likeVideo(data.id),
                                      child:
                                        Icon(Icons.favorite, color: data.likes.contains(authController.user.uid) ? Colors.red: Colors.white, size:40,),
                                    ),
                                    const SizedBox(height: 7,),
                                    Text(data.likes.length.toString(), style:const TextStyle(fontSize: 20, color: Colors.white,),),
                                    const SizedBox(height: 10,),
                                    InkWell(
                                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => CommentScreen(id: data.id, ),
                                      ),),
                                      child:
                                        const Icon(Icons.comment, color: Colors.white, size:40,),
                                    ),
                                    const SizedBox(height: 7,),
                                    Text(data.commentCount.toString(), style:const TextStyle(fontSize: 20, color: Colors.white,),),
                                    const SizedBox(height: 10,),
                                    InkWell(
                                      onTap: () => activityController.shareVideo(data.id),
                                      child:
                                        const Icon(Icons.reply_all_rounded, color: Colors.white, size:40,),
                                    ),
                                    const SizedBox(height: 7,),
                                    Text(data.shareCount.toString(), style:const TextStyle(fontSize: 20, color: Colors.white,),),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                                CircleAnimation(
                                  child: buildMusicAlbum(data.profilePhoto),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),)
                    ],
                  ),
                ],
              );
            },
          );
        }
      ),
      
    );
  }
}