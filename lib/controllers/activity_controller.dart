import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/models/video.dart';
import 'package:share_plus/share_plus.dart';

class ActivityController extends GetxController {
  final Rx<List<Video>> _followingVideos = Rx<List<Video>>([]);
  List<Video> get followingVideos => _followingVideos.value;

  @override
  void onInit() {
    super.onInit();
    getFollowingVideos();
  }

  getFollowingVideos() async {
    try {
      // Najpierw pobierz listę obserwowanych użytkowników
      QuerySnapshot followingSnapshot = await firebaseFirestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .get();

      List<String> followingIds = followingSnapshot.docs.map((doc) => doc.id).toList();
      
      // print("Current user ID: ${authController.user.uid}");
      // print("Following IDs: $followingIds");
      // print("Number of followed users: ${followingIds.length}");

      if (followingIds.isNotEmpty) {
        _followingVideos.bindStream(
          firebaseFirestore
              .collection('videos')
              .where('uid', whereIn: followingIds)
              //.orderBy('datePublished', descending: true)
              .snapshots()
              .map((QuerySnapshot query) {
            List<Video> retVal = [];
            //print("Found ${query.docs.length} videos from followed users");
            for (var element in query.docs) {
              
              retVal.add(Video.fromSnap(element));
            }
            return retVal;
          }),
        );
      } else {
        // print("No followed users found - showing empty list");
        _followingVideos.value = [];
      }
    } catch (e) {
      // print("Error getting following videos: $e");
    }
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await firebaseFirestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if((doc.data()! as dynamic)['likes'].contains(uid)){
      await firebaseFirestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    }
    else{
      await firebaseFirestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  shareVideo(String id) async {
    DocumentSnapshot doc = await firebaseFirestore.collection('videos').doc(id).get();
    var videoData = doc.data() as Map<String, dynamic>;
    
    await firebaseFirestore.collection('videos').doc(id).update({
      'shareCount': FieldValue.increment(1),
    });
    
    try {
      final String shareText = 'Check out this amazing video: ${videoData['caption'] ?? 'Video'}';
      final String videoUrl = videoData['videoUrl'] ?? '';
      
      await Share.share(
        '$shareText\n\n$videoUrl',
        subject: 'Amazing Video from MuFreak',
      );
      
      Get.snackbar('Success', 'Video shared successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to share video');
    }
  }
}