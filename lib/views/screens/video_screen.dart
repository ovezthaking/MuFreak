import 'package:flutter/material.dart';
import 'package:mufreak/views/widgets/circle_animation.dart';
import 'package:mufreak/views/widgets/video_player_item.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  buildProfile(String profilePhoto){
    return SizedBox(width: 60, height: 60, child:Stack(
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
      body: PageView.builder(
        //itemCount: ,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              //VideoPlayerItem(videoUrl: ,),
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
                                'username',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'caption',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.music_note_rounded, size:15, color: Colors.white,),
                                  Text(
                                  'song name',
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
                            buildProfile('string url'),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child:
                                    Icon(Icons.favorite, color: Colors.red, size:40,),
                                ),
                                const SizedBox(height: 7,),
                                Text("44,204", style:const TextStyle(fontSize: 20, color: Colors.white,),),
                                const SizedBox(height: 10,),
                                InkWell(
                                  onTap: () {},
                                  child:
                                    Icon(Icons.comment, color: Colors.white, size:40,),
                                ),
                                const SizedBox(height: 7,),
                                Text("47", style:const TextStyle(fontSize: 20, color: Colors.white,),),
                                const SizedBox(height: 10,),
                                InkWell(
                                  onTap: () {},
                                  child:
                                    Icon(Icons.reply_all_rounded, color: Colors.white, size:40,),
                                ),
                                const SizedBox(height: 7,),
                                Text("7", style:const TextStyle(fontSize: 20, color: Colors.white,),),
                                const SizedBox(height: 10,),
                              ],
                            ),
                            CircleAnimation(
                              child: buildMusicAlbum('profile photo'),
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
      ),
    );
  }
}