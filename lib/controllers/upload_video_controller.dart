import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController{

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath, quality: VideoQuality.MediumQuality,);
    return compressedVideo!.file;
  }

  //upload
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    //save to firestore
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async{
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    //save to firestore
    return downloadUrl;
  }

  List<String> extractMentions(String text) {
    final mentionRegex = RegExp(r'@(\w+)');
    final matches = mentionRegex.allMatches(text);
    return matches.map((match) => match.group(1)!).toList();
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try{
      List<String> mentions = extractMentions(caption);
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await firebaseFirestore.collection('users').doc(uid).get();
    //idd
    var allDocs = await firebaseFirestore.collection('videos').get();
    int len = allDocs.docs.length;
    String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
    String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

    Video video = Video(
      username: (userDoc.data()! as Map<String, dynamic>)['name'], 
      uid: uid, 
      id: "Video $len", 
      likes: [], 
      commentCount: 0, 
      shareCount: 0, 
      songname: songName, 
      caption: caption, 
      videoUrl: videoUrl, 
      thumbnail: thumbnail, 
      profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );
      
     await firebaseFirestore.collection('videos').doc('Video $len').set(
      video.toJson(),
     );
     Get.back();
     for (String mention in mentions) {
        await _notifyMentionedUser(mention, video.id);
      }
    }
    catch(e){
      Get.snackbar('Error uploading video', e.toString());
    }
  }

  _notifyMentionedUser(String username, String videoId) async {
    // Znajdź użytkownika po nazwie
    QuerySnapshot userQuery = await firebaseFirestore
        .collection('users')
        .where('name', isEqualTo: username)
        .get();
    
    if (userQuery.docs.isNotEmpty) {
      String userId = userQuery.docs.first.id;
      await firebaseFirestore.collection('notifications').add({
        'type': 'mention',
        'fromUserId': authController.user.uid,
        'toUserId': userId,
        'videoId': videoId,
        'timestamp': DateTime.now(),
        'read': false,
      });
    }
  }
}