import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/views/widgets/circle_animation.dart';
import 'package:get/get.dart';
import '../../controllers/video_controller.dart';
import '../widgets/video_player_int.dart';
import 'commentScreen.dart';

class VideoScreen extends StatelessWidget {
   VideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return SizedBox(width: 50, height: 60, child: Stack(
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
        )),
      ],
    ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(width: 60, child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(11),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Colors.grey,
                Colors.white,
              ]),
              borderRadius: BorderRadius.circular(25)
          ),
          child: ClipRRect(borderRadius: BorderRadius.circular(25),
            child: Image(
              image: NetworkImage(profilePhoto), fit: BoxFit.cover,),),
        )
      ],
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: data.videoUrl,),
                Expanded(child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment:   CrossAxisAlignment.end,
                  children: [
                    Expanded(child: Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(data.username, style: const TextStyle(fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),),
                          Text(data.caption, style: const TextStyle(fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),),
                          Row(children: [
                            const Icon(
                              Icons.music_note, size: 15, color: Colors.white,),
                            Text(data.songname, style: const TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),
                          ],),
                        ],
                      ),
                    )),
                  ],
                )
                ),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: size.height / 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildProfile(data.profilePhoto),
                      Column(
                        children: [
                          InkWell(
                            onTap: () => videoController.likeVideo(data.id),
                            child: Icon(
                              size: 40,
                              Icons.favorite,
                              color: data.likes.contains(authController.user.uid) ? Colors.red : Colors.white,
                            ),
                          ),
                          SizedBox(height: 7,),
                          Text(data.likes.length.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),),
                          InkWell(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentScreen(id: data.id))),
                            child: Icon(
                              size: 40,
                              Icons.comment,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 7,),
                          Text(data.commentCount.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              size: 40,
                              Icons.reply,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 7,),
                          Text(data.shareCount.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),),
                          CircleAnimation(
                              child: buildMusicAlbum(data.profilePhoto)),
                        ],
                      )
                    ],
                  ),
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
