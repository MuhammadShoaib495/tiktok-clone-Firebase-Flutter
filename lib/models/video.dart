import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songname;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  Video({
    required this.username,
    required this.thumbnail,
    required this.profilePhoto,
    required this.uid,
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.likes,
    required this.songname,
    required this.shareCount,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'thumbnail': thumbnail,
        'caption': caption,
        'id': id,
        'profilePhoto': profilePhoto,
        'commentCount': commentCount,
        'likes': likes,
        'songname': songname,
        'shareCount': shareCount,
        'videoUrl': videoUrl,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      username: snapshot['username'],
      uid: snapshot['uid'],
      thumbnail: snapshot['thumbnail'],
      caption:snapshot['caption'],
      id: snapshot['id'],
      profilePhoto: snapshot['profilePhoto'],
      commentCount: snapshot['commentCount'],
      likes:snapshot['likes'],
      songname: snapshot['songname'],
      shareCount: snapshot['shareCount'],
      videoUrl: snapshot['videoUrl']
    );
  }
}
